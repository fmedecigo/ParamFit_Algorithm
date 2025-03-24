% =========================================================================
%  Description:
%    This script generates and plots an astroid, a special type of 
%    hypocycloid with four cusps, using parametric equations.
%    The astroid is commonly used in mathematical modeling and shape 
%    approximation.
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

% Define the astroid parameter
a = 5; % This value can be adjusted to change the size of the astroid

% Parametric equations of the astroid
x = a * cos(t).^3;
y = a * sin(t).^3;

% Plot the astroid
figure;
plot(x, y, 'b-', 'LineWidth', 2);
title('Astroid');
xlabel('X-axis');
ylabel('Y-axis');
axis equal;
grid on;
