% =========================================================================
%  Description:
%    This script generates and plots a parametric curve resembling a mouth 
%    shape using trigonometric functions. The shape is defined using 
%    a cosine function for the x-coordinates and a sine-powered function 
%    for the y-coordinates.
%
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


clc;
clear;

% Define the parameterization interval
theta = linspace(0, 2*pi, 100);  % Vector of theta values from 0 to 2π

% Define shape parameters
a = 15;
b = 8;

% Compute the parametric equations
x = a * cos(theta);         % x-coordinate as a function of theta
y = a * (sin(theta)).^3;    % y-coordinate as a function of theta

% Plot the curve
figure;
plot(x, y, 'k.', 'LineWidth', 2);  

% Formatting
axis equal;  % Ensure equal scaling on both axes
set(gca, 'XTick', [], 'YTick', []);  % Remove axis ticks
