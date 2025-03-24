% =========================================================================
%  Description:
%    This script generates and plots various parametric shapes by adjusting 
%    the parameters a, b, c, d, n, and m. The model is capable of 
%    generating different geometric figures, including cardioids, ellipses, 
%    egg-shaped forms, and more complex shapes.
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
t = linspace(0, 2*pi, 360);

%% Shape Configurations (Uncomment one to use)

%% If a = b, c = d, and n = m = 1, the shape is a CARDIOID
% b = 15;
% d = 5;
% m = 1;
% a = b;
% c = d;
% n = m;

%% If b = 0, c > d (but c should not exceed d by much), and n = m = 1, the shape is an EGG SHAPE
% b = 0;
% a = 5;
% c = 4;
% d = 1;
% m = 1;
% n = m;

%% If b = d = 0, the shape is an ELLIPSE; if a = c, it is a CIRCLE
% b = 0;
% d = 0;
% a = 2;
% c = a;
% m = 1;
% n = m;

%% If n = m = 3, a > b, and c > d, the shape is a ROUNDED-TRIANGLE
% a = 10;
% b = 5;
% c = 8;
% d = 2;
% n = 3;
% m = 3;

%% If n = m = 4, a > b, and c > d, the shape is a RECTANGULAR OBLONG
% a = 20;
% b = 1;
% c = 10;
% d = 5;
% n = 4;
% m = 4;

%% If b < a and c = d, the shape is a DROP
% b = 3;
% a = 10;
% c = 5;
% d = 5;
% m = 1;
% n = m;

%%%% Geometric petals  (n and m values define the petals number)
a = 10;
b = a / 2;
c = a;
d = b;
m = 6;
n = m;

%% If n = m = 3, a > b, and c > d, the shape is a ROUNDED-TRIANGLE
% a = 10;
% b = a / 2;
% c = b;
% d = b / 2;
% n = 3;
% m = 3;

%%%%%%%%%%%%%%


% Compute the parametric equations
x = ((a + b*cos(n*t)) .* cos(t))';
y = ((c + d*cos(m*t)) .* sin(t))';

% Plot the parametric shape
figure;
plot(x, y, 'k.');
axis off;
axis equal;

