function a = alpha0(r, theta)
%------------------------------------------------------------------------------
% Author: Kjartan Myrdal
%
% Inputs:
%  r     - The step size ratio between the current and the last step.
%  theta - Parameter determining the two-step method used.
%
% Output:
%  a - The coefficient alpha_0 for an explicit two step method.
%
% Computes the coefficient alpha_0 of an explicit two step method that is
% determined by the parameter theta and with respect to the step size ratio r.
%------------------------------------------------------------------------------
    a = - (r^2 * cos(theta)) / (cos(theta) - 2 * sin(theta));
end