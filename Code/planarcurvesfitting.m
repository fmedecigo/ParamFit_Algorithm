%% Load and process outline data from an Excel file
% This script reads 2D outline data from an Excel file and applies 
% nonlinear least squares fitting using a parametric model.
%
% Steps:
%   1. Read the outline points from an Excel file.
%   2. Preprocess and clean NaN values.
%   3. Compute the centroid and rotation angle using PCA.
%   4. Initialize parametric model values.
%   5. Perform nonlinear least squares fitting.
%   6. Display and compare original and fitted outlines.
%
% Outputs:
%   - Jaccard index measuring similarity between original and fitted outlines.
%   - Regression metrics (R² and RMSE) for X and Y coordinates.
%
% Note: If the file does not exist, an error message will be displayed.


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
close all;

% Define the file path
filePath = 'C:\Users\medec\OneDrive\Escritorio\MACTE\Proyecto\aplicaciones\curvas\recrear\CurveML\CurveML\training\mouth\000005\point_set_clean.csv';

% Check if the file exists before attempting to read
if exist(filePath, 'file') == 2
    % Read numerical data only
    A = readmatrix(filePath);
    
    % If headers are needed, use:
    % T = readtable(filePath); A = table2array(T);
    
else
    error('File not found: %s', filePath);
end

%% Extract original outline points
x_in = A(:,1); 
y_in = A(:,2);  
x_sin = x_in(~isnan(x_in)); 
y_sin = y_in(~isnan(y_in));
x = x_sin(1:end);
y = y_sin(1:end);

X = [x, y];

% Compute the centroid
z = [mean(X(:,1)), mean(X(:,2))]';

% Compute rotation angle using PCA
alpha = calcular_alpha_pca_ajustado(X);

% Initial parameter values for fitting

%%% Pascal Snail

% a = sqrt(mean(sum((X - z').^2, 2)));
% b = a / 2;
% cc = a; 
% d = b;
% n =1;
% m =1;
% ox = z(1);
% oy = z(2);

%%% Circle (Cassinian oval)

% a = sqrt(mean(sum((X - z').^2, 2)));
% b = 0;
% cc = a; 
% d = b;
% n =1;
% m =1;
% ox = z(1);
% oy = z(2);

%%% Ellipse / Egg Shape

% a = sqrt(mean(sum((X - z').^2, 2)));
% b = 0;
% cc = a/2; 
% d = b;
% n =1;
% m =1;
% ox = z(1);
% oy = z(2);

%%% Cardioid
 
% a = sqrt(mean(sum((X - z').^2, 2)));
% b = a;
% cc = a; 
% d = cc;
% n =1;
% m =1;
% ox = z(1);
% oy = z(2);

%%% Nephroid
 
% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a;
% cc=2*a;
% d=a;
% n=2;
% m=2;
% ox = z(1);
% oy = z(2);

%%% Rounded-Triangle
 
% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/2;
% cc=a;
% d=b;
% n=3;
% m=3;
% ox = z(1);
% oy = z(2); 

%%% Rectangular Oblong

% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/2;
% cc=a;
% d=b;
% n=4;
% m=4;
% ox = z(1);
% oy = z(2); 

%%% Drop

% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/2;
% cc=a;
% d=a;
% n=1;
% m=1;
% ox = z(1);
% oy = z(2); 

%%% Hypotrochoid

% a=rand;
% b=a/2;
% cc=a;
% d=-b;
% n=1;
% m=1;
% ox = z(1);
% oy = z(2); 


%%% Astroid (4-Cusped Hypocycloid)
 
% a=rand;
% b=a/4;
% cc=a;
% d=-b;
% n=2;
% m=2;
% ox = z(1);
% oy = z(2); 

%%% Rounded Rhombus

% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/3;
% cc=a;
% d=-b;
% m=2;
% n=2;
% ox = z(1);
% oy = z(2); 

%%% Geometric petals 
 
% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/2;
% cc=a;
% d=b;
% m=5;
% n=5;
% ox = z(1);
% oy = z(2); 

%%% Boomerang

% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=2*a;
% cc=2*a;
% d=a/2;
% m=1;
% n=1;
% ox = z(1);
% oy = z(2); 

%%% Fish

% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/2;
% cc=2*a;
% d=a;
% m=2;
% n=1;
% ox = z(1);
% oy = z(2); 

%%% Aomeba 5

% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/2;
% cc=a;
% d=b;
% n=5;
% m=5;
% ox = z(1);
% oy = z(2); 

%%% Amoeba 6

% a=sqrt(mean(sum((X - z').^2, 2))) ;
% b=a/2;
% cc=a;
% d=b;
% n=6;
% m=6;
% ox = z(1);
% oy = z(2); 

%%% Mouth Shape
 
a=sqrt(mean(sum((X - z').^2, 2))) ;
b=0;
cc=a/2;
d=b;
n=1;
m=2;
ox = z(1);
oy = z(2);


% Perform curve fitting
[z, a, b, cc, d, n, m, alpha, t, step, res] = ajuste(X, z, a, b, cc, d, n, m, alpha, 1);

% Display final residual norm
disp(['Final residual norm: ', num2str(norm(res))]);

%% Generate fitted outline points
theta = linspace(0, 2*pi, size(X,1));
X_ajus = (a + b*cos(n*theta)).*cos(theta);
Y_ajus = (cc + d*cos(m*theta)).*sin(theta);
Xx = [X_ajus', Y_ajus'];

% Apply inverse rotation to fitted points
s = sin(-alpha);
c = cos(-alpha);
Q = [c -s; s c];
Xs = (Xx * Q);

% Translate fitted points back to original centroid
XX = Xs + z';

%% Plot original vs. fitted outline
Xii = X(1:10:end, :);
XXii = XX(1:10:end, :);

figure;
plot(Xii(:,1), Xii(:,2), 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'none', 'MarkerSize', 8, 'LineWidth', 1.5, 'DisplayName', 'Original outline');
hold on;
plot(XXii(:,1), XXii(:,2), '*', 'MarkerEdgeColor', [0.4 0.4 0.4], 'MarkerSize', 6, 'LineWidth', 1.5, 'DisplayName', 'Fitted outline');
legend('FontSize', 12, 'Location', 'best');

% Compute Jaccard index
ind_jaccard = metjaccard(X, XX(:,1), XX(:,2), 'Fitted Outline');

%% Compute regression metrics
x_original = X(:, 1);
y_original = X(:, 2);
x_fitted = XX(:, 1);
y_fitted = XX(:, 2);

% Linear fit for x-coordinates
modelo_x = fitlm(x_original, x_fitted);
R2_x = modelo_x.Rsquared.Ordinary;
RMSE_x = sqrt(modelo_x.MSE);

% Linear fit for y-coordinates
modelo_y = fitlm(y_original, y_fitted);
R2_y = modelo_y.Rsquared.Ordinary;
RMSE_y = sqrt(modelo_y.MSE);

% Display results
fprintf('R² for x: %.4f\n', R2_x);
fprintf('RMSE for x: %.4f\n', RMSE_x);
fprintf('R² for y: %.4f\n', R2_y);
fprintf('RMSE for y: %.4f\n', RMSE_y);