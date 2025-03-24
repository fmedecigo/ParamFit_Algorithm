%% Extracts the largest contour from an image
% This script processes an image to extract its largest contour by:
%   1. Converting the image to grayscale (if necessary)
%   2. Selecting the optimal Gaussian filter parameter (sigma)
%   3. Applying Gaussian filtering
%   4. Performing binarization using Otsu's method
%   5. Detecting and extracting the largest contour
%   6. Displaying different stages of the contour extraction process
%
% Note: If the extracted contour is not appropriate, you can manually define 
%       the optimal sigma by setting `sigma_optimo` manually.
%
% Outputs:
%   - x, y: Coordinates of the largest detected contour
%   - Various figures showing the image processing steps



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


%% Extracts the largest contour from an image
% This script processes an image to extract its largest contour by:
%   1. Converting the image to grayscale (if necessary)
%   2. Selecting the optimal Gaussian filter parameter (sigma)
%   3. Applying Gaussian filtering
%   4. Performing binarization using Otsu's method
%   5. Detecting and extracting the largest contour
%   6. Displaying different stages of the contour extraction process
%
% Note: If the extracted contour is not appropriate, you can manually define 
%       the optimal sigma by setting `sigma_optimo` manually.
%
% Outputs:
%   - x, y: Coordinates of the largest detected contour
%   - Various figures showing the image processing steps

% Read the image

% ruta=imread('C:\Users\medec\OneDrive\Escritorio\MACTE\Proyecto\Circulo o elipse\ajustes\figurasinnombre\pulido\diatomeas\batch1\batch1\000125B.TIF');
ruta = imread('C:\Users\medec\OneDrive\Escritorio\MACTE\Proyecto\Circulo o elipse\ajustes\figurasinnombre\pulido\semillas\seleccion\Avena_Fatua_A_Control.png');
img = ruta; % Define the image

% Convert to grayscale if necessary
if size(img, 3) == 3
    img_gris = rgb2gray(img);
else
    img_gris = img;
end

% Select optimal sigma based on Fourier Transform analysis
% sigma_optimo = mejorsigma(img_gris);
sigma_optimo = 1; % Uncomment to manually set sigma if needed

% Apply Gaussian filtering with the selected sigma
img_filtrada = imgaussfilt(img_gris, sigma_optimo);

% Binarization using Otsu's threshold
valorumbral = graythresh(img_filtrada);
binarizacion = imbinarize(img_filtrada, valorumbral);
binarizacion = ~binarizacion;  % Invert binary image for contour detection

% Detect outer contours without internal holes
bordes = bwboundaries(binarizacion, 'noholes');

% Find the largest contour
longitudes = cellfun(@length, bordes);
[~, idxLargest] = max(longitudes);
contornoMasGrande = bordes{idxLargest};

% Display results
figure 
imshow(img);
title('Original Image');

figure 
imshow(img_gris);
title('Grayscale Image');

figure 
imshow(img_filtrada);
title(['Filtered Image with \sigma = ', num2str(sigma_optimo)]);

figure 
imshow(binarizacion);
title('Binary Image (Otsu’s Threshold)');

figure
L = labelmatrix(bwconncomp(binarizacion));
numLabels = max(L(:));

% Create a grayscale colormap
colormap = repmat(linspace(0.1, 0.7, numLabels)', 1, 3);

% Display detected contours
imshow(label2rgb(L, colormap, 'k', 'shuffle'));
title('Detected Contours');

figure 
hold on;
contornoMasGrande = contornoMasGrande(1:8:end, :);
plot(contornoMasGrande(:,2), -contornoMasGrande(:,1), 'k.', 'LineWidth', 5);
axis off
hold off;
title('Largest Contour');

% Save contour coordinates
if ~isempty(contornoMasGrande)
    x = contornoMasGrande(:, 2)';
    y = -contornoMasGrande(:, 1)';
    x2 = contornoMasGrande(:, 2);
    y2 = contornoMasGrande(:, 1);
end

% Summary figure showing the entire processing pipeline
figure

% Original Image
subplot('Position', [0.05, 0.55, 0.27, 0.4]) 
imshow(img)

% Grayscale Image
subplot('Position', [0.37, 0.55, 0.27, 0.4])
imshow(img_gris)

% Filtered Image
subplot('Position', [0.69, 0.55, 0.27, 0.4])
imshow(img_filtrada)

% Binary Image (Otsu)
subplot('Position', [0.05, 0.05, 0.27, 0.4])
imshow(binarizacion)

% All detected contours
subplot('Position', [0.37, 0.05, 0.27, 0.4])
imshow(label2rgb(L, colormap, 'k', 'shuffle'));

% Largest Contour (smaller and centered)
axes('Position', [0.72, 0.10, 0.20, 0.30])
hold on;
plot(contornoMasGrande(:, 2), -contornoMasGrande(:, 1), 'k-', 'LineWidth', 2);
axis off
hold off
