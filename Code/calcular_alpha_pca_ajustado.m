%% Computes the adjusted PCA-based rotation angle
% This function calculates the optimal rotation angle (alpha) using 
% Principal Component Analysis (PCA) on a set of 2D points.
%
% Inputs:
%   - X: A [n, 2] matrix where each row is a point [x, y].
%
% Outputs:
%   - alpha: Rotation angle in radians, adjusted to be within [0, 2*pi].

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



function alpha = calcular_alpha_pca_ajustado(X)

% 1. Compute the centroid (geometric center)
centroide = mean(X, 1);

% 2. Center the points around the origin
puntos_centrados = X - centroide;

% 3. Compute the covariance matrix
covarianza = cov(puntos_centrados);

% 4. Obtain the eigenvectors and eigenvalues of the covariance matrix
[vectores_propios, ~] = eig(covarianza);

% 5. Find the principal direction (largest eigenvalue)
direccion_principal = vectores_propios(:, 2); % Eigenvector corresponding to the largest eigenvalue

% 6. Compute the rotation angle using the principal direction
alpha = atan2(direccion_principal(2), direccion_principal(1));

% 7. Ensure the angle is within the range [0, 2*pi]
if alpha < 0
    alpha = alpha + 2*pi;
end

end

   