%% Computes the Jaccard index for shape similarity
% This function calculates the Jaccard index to measure the similarity 
% between an experimental contour and an approximated contour obtained 
% using the ParamFit algorithm.
%
% Inputs:
%   - X: Original contour points [n, 2]
%   - x_ajustadas: Adjusted x-coordinates after fitting
%   - y_ajustadas: Adjusted y-coordinates after fitting
%   - nombre_forma_actual: Name of the current shape (used for visualization)
%
% Outputs:
%   - indJaccard: Jaccard index, defined as the ratio between the 
%                 intersection and union of the two contours


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

function indJaccard = metjaccard(X, x_ajustadas, y_ajustadas, nombre_forma_actual)

% Sort the original and fitted contour points in clockwise or counterclockwise order
k_experimental = boundary(X(:, 1), X(:, 2));
k_ajustado = boundary(x_ajustadas(:), y_ajustadas(:));

% Create polyshapes with the ordered points
contornoexperimental = polyshape(X(k_experimental, 1), X(k_experimental, 2));
contornoaproximado = polyshape(x_ajustadas(k_ajustado), y_ajustadas(k_ajustado));

% Compute the intersection of the contours
interseccion = intersect(contornoexperimental, contornoaproximado);
area_interseccion = area(interseccion);

% Compute the union of the contours
unionn = union(contornoexperimental, contornoaproximado);
area_union = area(unionn);

% Compute the Jaccard index
indJaccard = area_interseccion / area_union;

%% Visualization of the contours
figure;

% Transparency factor
alpha_factor = 0.3; % Higher transparency

% Plot the original contour (light gray)
plot(contornoexperimental, 'FaceColor', [1, 1, 1], 'FaceAlpha', alpha_factor); 
title(nombre_forma_actual); % Display shape name
hold on;

% Plot the fitted contour (darker shade for ParamFit)
plot(contornoaproximado, 'FaceColor', [0.15, 0.15, 0.15], 'FaceAlpha', alpha_factor * 0.6); 

% Plot the intersection area (dark gray)
if ~isempty(interseccion.Vertices)
    plot(interseccion, 'FaceColor', [0.15, 0.15, 0.15], 'FaceAlpha', alpha_factor * 1.2);
end

% Add legend
legend('Outline', 'ParamFit', 'Common Area', 'Location', 'best', 'FontSize', 12);
hold off;

end
