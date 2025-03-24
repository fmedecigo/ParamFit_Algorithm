% =========================================================================
%  Description:
%    This script generates and plots a hypotrochoid, a curve traced by a 
%    point attached to a circle of radius r rolling inside a fixed circle 
%    of radius R. The parametric equations define the trajectory based on 
%    the radii of the circles and the distance from the center of the rolling 
%    circle to the tracing point.
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

clear;
clc;

% Define the parameterization interval
t = linspace(0, 2*pi, 1000);  

% Define parameters for the hypotrochoid
R = 3; % Radius of the fixed circle
r = 1; % Radius of the rolling circle
d = 1; % Distance from the center of the rolling circle to the tracing point

% Compute the parametric equations of the hypotrochoid
x = (R - r) * cos(t) + d * cos((R - r) / r * t);
y = (R - r) * sin(t) - d * sin((R - r) / r * t);

% Plot the hypotrochoid
figure;
plot(x, y, 'b-', 'LineWidth', 2);

% Formatting
title('Hypotrochoid');
xlabel('X-axis');
ylabel('Y-axis');
axis equal;  % Ensure equal scaling on both axes
grid on;
