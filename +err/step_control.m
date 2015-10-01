function r = step_control(tol, err, r_old, ord)
%------------------------------------------------------------------------------
% Author: Kjartan Myrdal
%
% Inputs:
%  tol   - The tolerance that the local error should be kept under.
%  err   - The estimated error.
%  r_old - The step size ratio from previous iteration.
%  ord   - The order of the method.
%
% Output:
%  r - The new step size ratio.
%
% Computes the next step size ratio, given a tolerance for the local error and
% an estimation of the local error.
%------------------------------------------------------------------------------
    parvec = [1/6 1/6];
    %r = (tol / err)^(1./3);
    r = prod([(tol / err)^(1/(ord+1)) r_old] .^ parvec);
end