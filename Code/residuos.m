%% Computes the residual vector
% This function calculates the residual vector, which represents the 
% difference between the given points and the parametric curve model.
%
% Inputs:
%   - X: Given points <X(i,1), X(i,2)>
%   - x: Shape parameters vector
%
% Outputs:
%   - res: Residual vector representing the error between the given points 
%          and the fitted parametric curve


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


function res = residuos(X, x)

% Extract parameters from vector x
[t, n, m, alpha, a, b, cc, d, z] = parametros(x);

% Compute sine and cosine values for the rotation matrix
s = sin(alpha);  
c = cos(alpha);  

% Form the rotation matrix
Q = [c -s; s c]; 

% Undo the rotation of the given points
Xs = X * Q; 

% Undo the rotation of the centroid
zs = Q' * z;

% Compute the residual vector
res = [Xs(:,1) - (zs(1) + (a + b * cos(n * t)) .* cos(t)); 
       Xs(:,2) - (zs(2) + (cc + d * cos(m * t)) .* sin(t))];

end
