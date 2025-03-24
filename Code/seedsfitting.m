%% Parametric Fitting and Seed Classification
% This script performs nonlinear least squares fitting on seed outlines 
% using a parametric model and classifies them based on the best fit.
%
% Steps:
%   1. Read seed outline data from an Excel file.
%   2. Preprocess and remove empty cells.
%   3. Compute the centroid and rotation angle using PCA.
%   4. Initialize model parameters for different shape types.
%   5. Perform nonlinear least squares fitting.
%   6. Compute residuals and Jaccard index for each shape.
%   7. Identify the best-fitting shape and display results.
%
% Outputs:
%   - Best-fitting shape and its parameters.
%   - Residual norm for each tested shape.
%   - Jaccard index comparing original and fitted outlines.
%   - Regression metrics (R² and RMSE) for X and Y coordinates.


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
warning off;

%% Load seed outline data
filePath = 'C:\contornossemillas.xlsx'; 

% Check if the file exists before attempting to read
if exist(filePath, 'file') == 2
    % Read numerical data only
    A = readmatrix(filePath);
else
    error('File not found: %s', filePath);
end

%% Select outline data for classification

% x_in = A(:,3); % Avena Fatua 1
% y_in = A(:,4);

% Uncomment for other seed types:
x_in = A(:,13); % Galium Spurium 2
y_in = A(:,14);
% x_in = A(:,33); % Vaccaria Hispanica 3
% y_in = A(:,34);
% x_in = A(:,19); % Panicum Maximun 4
% y_in = A(:,20);
% x_in = A(:,29); % Thlaspi Arvense 5
% y_in = A(:,30);

%% Remove empty cells
x_sin = x_in(~isnan(x_in)); 
y_sin = y_in(~isnan(y_in));

%% Final outline coordinates
x = x_sin(1:end);
y = y_sin(1:end);
X = [x, y];

numPoints = size(x,1); % Compute number of points

%% Initial conditions
z = [mean(X(:, 1)), mean(X(:, 2))]'; % Compute centroid
alpha = calcular_alpha_pca_ajustado(X); % Compute initial rotation angle

%% Define initial parameter conditions for different shapes
shapeConditions = {
    'Pascal Snail', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 0, 1, 1;
    'Circle', sqrt(mean(sum((X - z').^2, 2))), 0, sqrt(mean(sum((X - z').^2, 2))), 0, 0, 1, 1;
    'Ellipse', sqrt(mean(sum((X - z').^2, 2))), 0, sqrt(mean(sum((X - z').^2, 2)))/2, 0, 0, 1, 1;
    'Egg Shape', sqrt(mean(sum((X - z').^2, 2))), 0, sqrt(mean(sum((X - z').^2, 2)))/2, 0, 0, 1, 1;
    'Cardioid', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2))), 0, 1, 1;
    'Nephroid', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2))), 2*sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2))), 0, 2, 2;
    'Rounded-Triangle', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 0, 3, 3;
    'Rectangular Oblong', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 0, 4, 4;
    'Drop', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2))), 0, 1, 1;
    'Hypotrochoid', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), -sqrt(mean(sum((X - z').^2, 2)))/2, 0, 1, 1;
    'Astroid (4-Cusped Hypocycloid)', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/4, sqrt(mean(sum((X - z').^2, 2))), -sqrt(mean(sum((X - z').^2, 2)))/4, 0, 2, 2;
    'Rounded Rhombus', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/3, sqrt(mean(sum((X - z').^2, 2))), -sqrt(mean(sum((X - z').^2, 2)))/3, 0, 2, 2;
    'Geometric petals', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 0, 5, 5;
    'Boomerang', sqrt(mean(sum((X - z').^2, 2))), 2*sqrt(mean(sum((X - z').^2, 2))), 2*sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 0, 1, 1;
    'Fish', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 2*sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2))), 0, 2, 1;
    'Amoeba 5', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 0, 5, 5;
    'Amoeba 6', sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, sqrt(mean(sum((X - z').^2, 2))), sqrt(mean(sum((X - z').^2, 2)))/2, 0, 6, 6;
    'Mouth Shape', sqrt(mean(sum((X - z').^2, 2))), 0, sqrt(mean(sum((X - z').^2, 2)))/2, 0, 0, 1, 2;
};

%% Initialize matrices to store residuals and parameters
residuals = [];
newResiduals = [];
parameters = [];
jaccardIndices = [];
shapeNames = {};

%% Fit each shape and compute errors
for i = 1:size(shapeConditions, 1)
    shapeName = shapeConditions{i, 1};
    disp(shapeName);
    
    % Extract initial conditions
    a = shapeConditions{i, 2};
    b = shapeConditions{i, 3};
    cc = shapeConditions{i, 4};
    d = shapeConditions{i, 5};
    n = shapeConditions{i, 7};
    m = shapeConditions{i, 8};

    % Perform nonlinear fitting
    [z, a, b, cc, d, n, m, alpha, t, step, res] = ajuste(X, z, a, b, cc, d, n, m, alpha, 1);

    % Compute adjusted coordinates using the proposed parameterization
    [x_adjusted, y_adjusted] = calcular_coordenadas(z, a, b, cc, d, n, m, alpha, t);

    % Compute residuals
    newRes = [X(:, 1) - x_adjusted; X(:, 2) - y_adjusted];

    % Store results
    residuals = [residuals; res'];
    newResiduals = [newResiduals; newRes'];
    parameters = [parameters; a, b, cc, d, alpha, n, m];

    % Compute Jaccard index
    jaccardIndex = metjaccard(X, x_adjusted, y_adjusted, shapeName);

    % Store metrics
    jaccardIndices = [jaccardIndices; jaccardIndex];
    shapeNames = [shapeNames; shapeName];
    fprintf('\n')
end

%% Identify best-fitting shape
[~, bestIndex] = max(jaccardIndices);

bestParams = parameters(bestIndex, :);
bestShape = shapeConditions{bestIndex, 1};
bestResidual = norm(residuals(bestIndex, :));
bestJaccard = max(jaccardIndices);

% Display results
disp(['Best Shape (initial): ', bestShape]);
disp(['Residual Norm: ', num2str(bestResidual)]);
disp(['Jaccard Index: ', num2str(bestJaccard)]);

%% Generate and plot the best-fitting outline
a = bestParams(1);
b = bestParams(2);
cc = bestParams(3);
d = bestParams(4);
alpha = bestParams(5);
n = bestParams(6);
m = bestParams(7);

theta = t';
X_adj = (a + b*cos(n*theta)).*cos(theta);
Y_adj = (cc + d*cos(m*theta)).*sin(theta);
Xx = [X_adj', Y_adj'];

% Apply inverse rotation
s = sin(-alpha);
c = cos(-alpha);
Q = [c -s; s c];
Xs = (Xx * Q);

% Translate fitted points to original centroid
XX = Xs + z'; 

% Plot
figure;
plot(X(:,1), X(:,2), '.', 'MarkerEdgeColor', [0.4 0.4 0.4], 'MarkerFaceColor', 'none', 'MarkerSize', 9, 'LineWidth', 1.5, 'DisplayName', 'Original outline');
hold on;
plot(XX(:,1), XX(:,2), '-', 'Color', 'k', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Fitted outline');
legend('FontSize', 12, 'Location', 'best');

%% Compute regression metrics
x_original = X(:, 1);
y_original = X(:, 2);
x_fitted = XX(:, 1);
y_fitted = XX(:, 2);

modelo_x = fitlm(x_original, x_fitted);
modelo_y = fitlm(y_original, y_fitted);

R2_x = modelo_x.Rsquared.Ordinary;
RMSE_x = sqrt(modelo_x.MSE);
R2_y = modelo_y.Rsquared.Ordinary;
RMSE_y = sqrt(modelo_y.MSE);

% Display results
fprintf('R² for x: %.4f\n', R2_x);
fprintf('RMSE for x: %.4f\n', RMSE_x);
fprintf('R² for y: %.4f\n', R2_y);
fprintf('RMSE for y: %.4f\n', RMSE_y);
