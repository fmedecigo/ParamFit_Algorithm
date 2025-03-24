%% Computes the adjusted coordinates
% This function calculates the adjusted coordinates of a parametric curve
% after applying rotation and translation transformations.
%
% Inputs:
%   - z: Center of the fitted shape [z_x, z_y]
%   - a, b, c, d: Curve parameters
%   - n, m: Frequency parameters
%   - alpha: Rotation angle (radians)
%   - t: Vector of parameterized angles
%
% Outputs:
%   - x_ajustadas: Adjusted x-coordinates after transformation
%   - y_ajustadas: Adjusted y-coordinates after transformation



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
function [x_ajustadas, y_ajustadas] = calcular_coordenadas(z, a, b, cc, d, n, m, alpha, t)

% Generate the adjusted points (Fitted curve)
X_ajus = (a + b*cos(n*t')).*cos(t');
Y_ajus = (cc + d*cos(m*t')).*sin(t');
Xx = [X_ajus', Y_ajus'];

% Rotate the fitted curve using the inverse rotation matrix
s = sin(-alpha);  % Invert angle to rotate in the opposite direction
c = cos(-alpha);    
Q = [c -s; s c];

% Apply inverse rotation to the fitted points
Xs = (Xx * Q);

% Translate the adjusted points back to the original centroid
XX = Xs + z'; 
x_ajustadas = XX(:, 1);
y_ajustadas = XX(:, 2);

end

