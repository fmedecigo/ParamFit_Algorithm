%% Selects the optimal sigma value for Gaussian filtering
% This function determines the optimal sigma value for Gaussian filtering 
% by minimizing the energy in high frequencies of the Fourier Transform.
%
% Inputs:
%   - img: Input image (grayscale or single-channel)
%
% Outputs:
%   - sigma_optimo: Optimal sigma value that minimizes high-frequency energy


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
function sigma_optimo = mejorsigma(img)

valoressigma = 0.5:0.1:100; % Range of sigma values to evaluate
energia = zeros(size(valoressigma)); % Store energy scores

for i = 1:length(valoressigma)
    sigma = valoressigma(i);
    imagenfiltrada = imgaussfilt(img, sigma); % Apply Gaussian filter
    
    % Fourier Transform of the filtered image
    F = fft(double(imagenfiltrada));
    F_espectro = fftshift(F); % Center the spectrum
    
    % Compute total energy in high frequencies
    energia(i) = sum(abs(F_espectro(:)).^2);
end

% Find the index of the minimum energy value
[~, idx] = min(energia);
sigma_optimo = valoressigma(idx); % Sigma that minimizes high-frequency energy

end
