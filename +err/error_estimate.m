function err = error_estimate(c, c_err, x, x_err)
%------------------------------------------------------------------------------
% Author: Kjartan Myrdal
%
% Inputs:
%  c     - Error constant of the main method.
%  c_err - Error constant of the comparison method.
%  x     - Solution of the main method.
%  x_err - Solution of the comparison method.
%
% Output:
%  err - The estimated error of the main solution.
%
% Estimates the error of a multistep method using solutions from two different
% sets of coefficients and their error constant.
%------------------------------------------------------------------------------
    err = abs(c/(c-c_err))*norm(x_err - x);
end