%% Computes the fitting for the parametric shape
% x = z(1) + (a + b cos (nt))*cos (t), y = z(2) + (c + d cos (mt))* sin (t)
%%% Requires initial values for the parameters to be estimated
% X: Given points <X(i,1), X(i,2)>
% z, a, b, c, d, n, m, alpha: initial values


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



function [z, a, b, cc, d, n, m, alpha, t, step, res] = ajuste(X, z, a, b, cc, d, n, m, alpha, show)

if (nargin < 7), show = 0; end
epsr = 1e-15; % Precision definition, controls tolerance for convergence
k = size(X, 1); % Number of points
x = zeros(k+9, 1); % Initialize the parameter vector
t = 0:2*pi/(k-1):2*pi; % Initial values for angles t_i 
x = vector(x, t, n, m, alpha, a, b, cc, d, z); % Call to "vector" function to create the parameter vector
step = 0; % Iteration counter
normr = 1; % Stopping parameter
norma = 1; % Stopping parameter
lambda = [1;1;1]; % Initial values for lambda (for Levenberg-Marquardt fitting)

% Main iteration loop for shape fitting
while (normr > epsr * norma) % Stopping condition based on relative change
    % Call to the ALM optimization function
    [x, lambda, res] = alm(X, x, lambda);

    % Compute the norm of the difference between current and previous parameters
    if (step > 0)
        normr = norm(x - prevx); % Change in parameters
        norma = norm(x); % Magnitude of current parameters
    end
    prevx = x;
    step = step + 1;

    % Display parameters at each iteration if enabled
    if (show == 1)
        % disp(['Iteration: ', num2str(step)]);
        % disp(['normr: ', num2str(normr)]);
        % disp(['norma: ', num2str(norma)]);
        % disp(['epsr * norma: ', num2str(epsr * norma)]);
    end

    % Stopping condition based on maximum number of iterations
    if (step > 300)
        disp('Maximum number of iterations exceeded');
        break;
    end
end

% Extract final parameters after fitting using the "parametros" function
[t, n, m, alpha, a, b, cc, d, z] = parametros(x);
% step
end
