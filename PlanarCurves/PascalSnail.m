% =========================================================================
%  Description:
%    This script generates and plots the Pascal Snail, a parametric 
%    curve defined using a rational function. The Pascal Snail is widely 
%    studied in mathematical modeling and has applications in shape 
%    approximation and geometric analysis.
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

% Define parameters for the Pascal Snail
a = 10;
b = 5;  % Adjust parameter b to modify the shape of the Pascal Snail

% Define the parameterization range
t = linspace(0, 2*pi, 360);

% Compute the parametric equations of the Pascal Snail
x = a * cos(t) + b * cos(2*t);
y = a * sin(t) + b * sin(2*t);

% Plot the Pascal Snail
figure;
plot(x, y, 'k.', 'MarkerSize', 8);
axis off;  % Remove axes
axis equal;  % Ensure equal scaling on both axes

