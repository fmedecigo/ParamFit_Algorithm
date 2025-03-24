%% Extracts individual parameters from the parameter vector
% This function extracts the individual parameters from a given vector x, 
% which stores the angles, curve parameters, and centroid coordinates.
%
% Inputs:
%   - x: Parameter vector containing angles, shape parameters, and centroid coordinates.
%
% Outputs:
%   - t: Vector of angles
%   - n, m: Frequency parameters
%   - alpha: Rotation angle (radians)
%   - a, b, c, d: Shape parameters
%   - z: Centroid coordinates [z_x, z_y]

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


function [t, n, m, alpha, a, b, cc, d, z] = parametros(x)

% Compute the number of angle values
k = size(x, 1) - 9; % Calculate the size of the parameter vector

% Extract individual parameters
t = x(1:k); % Extract k angle values
n = x(k+1); % Extract parameter n
m = x(k+2); % Extract parameter m
alpha = x(k+3); % Extract rotation angle
a = x(k+4); % Extract parameter a
b = x(k+5); % Extract parameter b
cc = x(k+6); % Extract parameter c
d = x(k+7); % Extract parameter d
z = x(k+8:k+9); % Extract centroid coordinates [x, y]

end
