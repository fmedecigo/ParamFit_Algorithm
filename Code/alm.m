
%% Performs a step of the Levenberg-Marquardt method
% This function executes one iteration of the Levenberg-Marquardt algorithm 
% to optimize the parameters of the parametric curve fitting.
%
% Inputs:
%   - X: Given data points <X(i,1), X(i,2)>
%   - x: Current parameter vector
%   - lambda: Regularization parameter for the Levenberg-Marquardt method
%
% Outputs:
%   - x: Updated parameter vector after the iteration
%   - lambda: Updated lambda value
%   - res: Residual vector after the parameter update


% =========================================================================
%  A Parametric Function for Fitting Simple Closed Curves: The ParamFit Algorithm
%  
%  Authors:
%    Felipe A. Medécigo-Cabriales 1
%    Francisco Alejandro Alaffita-Hernández 1
%    Beatris Adriana Escobedo-Trujillo 2
%
%  Affiliation:
%    1 Centro de Investigación en Recursos Energéticos y Sustentables, 
%       Universidad Veracruzana, Coatzacoalcos, Veracruz, México.
%    2 Facultad de Ingeniería, Universidad Veracruzana, 
%       Coatzacoalcos, Veracruz, México.
%
%  Contact:
%    Corresponding author: bescobedo@uv.mx
%
%  Description:
%    This script/function is part of the ParamFit algorithm implementation,
%    which provides a parametric function for fitting simple closed curves
%    using the Levenberg-Marquardt optimization method. The method has 
%    been successfully applied to the classification of seeds, diatoms, 
%    and geometric planar curves.
%
%  Citation:
%    If you use this code, please cite:
%    "A Parametric Function for Fitting Simple Closed Curves: The ParamFit Algorithm", Medécigo-Cabriales et al.
% =========================================================================


function [x, lambda, res] = alm(X, x, lambda)

[t, n, m, alpha, a, b, cc, d, z] = parametros(x); % Extract parameters from vector x
omega = 0.5; % Adjustment factor for lambda
k = size(X, 1);

% Compute the initial residual vector
Y = residuos(X, x);

%% Construct the Jacobian matrix %%

%%% Sine and cosine terms involved in function derivatives
senoalpha = sin(alpha);
cosenoalpha = cos(alpha);
cosnti = cos(n * t);
sinnti = sin(n * t);
cosmti = cos(m * t);
sinmti = sin(m * t);
costi = cos(t);
sinti = sin(t);

A = [-(cc + d * cosmti) .* sinti, -t .* b .* sinnti .* costi, zeros(size(t)), costi, cosnti .* costi, zeros(size(t)), zeros(size(t)), cosenoalpha * ones(size(t)), senoalpha * ones(size(t))]; % Upper part of derivatives
B = [(a + b * cosnti) .* costi, zeros(size(t)), -t .* d .* sinmti .* sinti, zeros(size(t)), zeros(size(t)), sinti, cosmti .* sinti, -senoalpha * ones(size(t)), cosenoalpha * ones(size(t))]; % Lower part of derivatives

% Givens rotations for solution stabilization
[cg, sg] = rotgivens(-(a + b * cosnti) .* sinti - (n * b .* sinnti .* costi), (cc + d * cosmti) .* costi - (m * d .* sinmti .* sinti)); % Apply Givens rotations
G = sparse([diag(cg), -diag(sg); diag(sg), diag(cg)]);

Y = G * Y; % Rotate residuals
D = ((-(a + b .* cosnti) .* sinti - n .* b .* sinnti .* costi) .* cg) - (((cc + d .* cosmti) .* costi - m .* d .* sinmti .* sinti) .* sg); % Includes derivatives w.r.t. angles t_i
AB = G * [A; B]; % Form and rotate the Jacobian matrix

%% Levenberg-Marquardt step
paso = 0;
while (1)

    %%% Levenberg-Marquardt step
    [cg, sg] = rotgivens(D, lambda(1) * ones(k, 1));
    DD = D .* cg - lambda(1) .* sg;
    AA = sparse(diag(cg)) * AB(1:k, :);
    YY = [sparse(diag(cg)) * Y(1:k, :); Y(k+1:2*k, :); sparse(diag(sg)) * Y(1:k, :)];

    BB = [AB(k+1:2*k, :); sparse(diag(sg)) * AB(1:k, :); lambda(1) * eye(9, 9)];
    [qq, RR] = qr(BB);
    YY = [YY(1:k, :); qq(1:2*k, 1:9)' * YY(k+1:3*k, :)];
    JJ = [diag(DD), AA; zeros(9, k), RR(1:9, :)];

    % Compute parameter update and residuals
    delta = pinv(JJ) * YY;
    res = residuos(X, x + delta);
    h = norm(Y) - norm(res); % Improvement measure in residual norm

    % Internal stopping condition based on residual improvement
    if (h >= 0), break; end;

    %%% Update lambda factor
    lambda(1) = lambda(1)/omega;
    paso = paso + 1;

    % Stop condition based on max number of steps
    if (paso > 300)
        disp('Number of steps exceeded');
        break;
    end

end % while

if (paso == 0)
    lambda(1) = lambda(1)*omega;
end
x = x + delta;
end
