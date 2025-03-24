% =========================================================================
%  Description:
%    This script generates and plots a nephroid, a specific type of 
%    epicycloid formed when a circle rolls around another circle 
%    of twice its radius. The parametric equations describe the shape 
%    using trigonometric functions.
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

% Define the nephroid parameter (circle radius)
a = 1;

% Define the parameterization interval
theta = linspace(0, 2*pi, 360);  % Values from 0 to 2π

% Compute the parametric equations of the nephroid
x = a * (3 * cos(theta) + cos(3 * theta));
y = a * (3 * sin(theta) + sin(3 * theta));

% Plot the nephroid
figure;
plot(x, y, '.k');  

% Formatting
axis off;  % Remove axes
axis equal;  % Ensure equal scaling on both axes
