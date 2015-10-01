function r = upper_limit(r, thetas)
%------------------------------------------------------------------------------
% Author: Kjartan Myrdal
%
% Inputs:
%  r     - The step size ratio between the current and the last step.
%  theta - Parameter determining the two-step method used.
%
% Output:
%  r - The step size ratio.
%
% Makes sure that the step size ratio is not too high so that it doesn't cause
% instability of the method.
%------------------------------------------------------------------------------
    
    % Some factor to make sure that the value is below the upper limit.
    inner_point_factor = .99;

    % The smaller value of the previously computed step size ratio or the 
    % upper limit is chosen.
    r = min([r sqrt(abs(1 - 2 * tan(thetas))) * inner_point_factor]);
end

