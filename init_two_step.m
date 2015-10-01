function xs = init_two_step(f, x_0, t_0, h)
%------------------------------------------------------------------------------
% Inputs:
%  f   - The right hand side function of the differential equation.
%  x_0 - Initial value of the differential equation.
%  t_0 - Initial time value.
%  h   - Step size.

%
% Output:
%  xs - The solutions to the first two steps.
%
% Computes the first step of the ODE in order to start the multistep method.
% The method used is the built-in MATLAB function ode45.
%------------------------------------------------------------------------------

    [t, x] = ode45(f,[t_0, t_0 + h], x_0);
    xs     = [reshape(x(end, :), [], 1) x_0];
end