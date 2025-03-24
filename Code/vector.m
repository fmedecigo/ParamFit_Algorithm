%% Stores individual parameters into a vector
% This function stores the individual parameters of the parametric curve 
% into a single vector for optimization and processing.
%
% Inputs:
%   - x: Preallocated parameter vector
%   - t: Vector of angles
%   - n, m: Frequency parameters
%   - alpha: Rotation angle (radians)
%   - a, b, c, d: Shape parameters
%   - z: Centroid coordinates [z_x, z_y]
%
% Outputs:
%   - x: Updated parameter vector containing all values


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





function x = vector(x, t, n, m, alpha, a, b, cc, d, z)

% Compute the number of angle values
k = size(x, 1) - 9;

% Store each parameter into the vector, if not empty
if (~isempty(t)), x(1:k) = t; end
if (~isempty(n)), x(k+1) = n; end
if (~isempty(m)), x(k+2) = m; end
if (~isempty(alpha)), x(k+3) = alpha; end
if (~isempty(a)), x(k+4) = a; end
if (~isempty(b)), x(k+5) = b; end
if (~isempty(cc)), x(k+6) = cc; end
if (~isempty(d)), x(k+7) = d; end
if (~isempty(z)), x(k+8:k+9) = z; end

end
