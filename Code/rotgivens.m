%% Computes the sine and cosine values for Givens rotations
% This function calculates the cosine (c) and sine (s) values for 
% the Givens rotation matrix, which is used to rotate the component 'y' to zero.
%
% Inputs:
%   - x: Vector of x-components.
%   - y: Vector of y-components.
%
% Outputs:
%   - c: Vector of cosine values for the Givens rotation.
%   - s: Vector of sine values for the Givens rotation.


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




function [c, s] = rotgivens(x, y)

m = size(x,1);  % Get the number of elements in vector x (or y), i.e., the number of rotations to be performed.
c = zeros(m,1); s = zeros(m,1);  % Initialize output vectors c (cos) and s (sin) as column vectors of zeros with size m.

% Loop through each pair of components x(i) and y(i)
for i = 1:m
    % If the absolute value of y(i) is greater than x(i), use cotangent to avoid numerical instabilities
    if (abs(y(i)) > abs(x(i)))
        cot = -x(i)/y(i);  % Compute cotangent for rotation
        si = 1/sqrt(1 + cot^2);  % Compute sine using the trigonometric relation: sin(theta) = 1 / sqrt(1 + cot^2)
        co = si * cot;  % Compute cosine using the relation cos(theta) = sin(theta) * cot
    else
        % If the absolute value of x(i) is greater or equal to y(i), use tangent to avoid numerical instabilities
        tan = -y(i)/x(i);  % Compute tangent for rotation
        co = 1/sqrt(1 + tan^2);  % Compute cosine using the trigonometric relation: cos(theta) = 1 / sqrt(1 + tan^2)
        si = co * tan;  % Compute sine using the relation sin(theta) = cos(theta) * tan
    end
    
    % Assign the computed sine and cosine values to the output vectors
    s(i) = si;  % Store sine in vector s
    c(i) = co;  % Store cosine in vector c
end

end
