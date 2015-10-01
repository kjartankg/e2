function c = error_constant(r, theta)
%------------------------------------------------------------------------------
% Author: Kjartan Myrdal
%
% Inputs:
%  r     - The step size ratio between the current and the last step.
%  theta - Parameter determining the two-step method used.
%
% Output:
%  c - The error constant.
%
% Computes the error constant of the explicit two-step method determined by
% the parameter theta and with respect to the step size ratio r.
%------------------------------------------------------------------------------
    c = (1/6)*(cos(theta)*r-2*r*sin(theta)+cos(theta)-3*sin(theta)) / ...
        (r*(cos(theta)*r+cos(theta)-2*sin(theta)));
end