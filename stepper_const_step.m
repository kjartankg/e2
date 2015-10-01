function x_all = stepper_const_step(f, x_0, t_0, t_n, n, theta)
%------------------------------------------------------------------------------
% Author: Kjartan Myrdal
%
% Inputs:
%  f     - The right hand side function of the differential equation.
%  x_0   - Initial value of the differential equation.
%  t_0   - Initial time value.
%  t_n   - Final time value.
%  n     - Number of steps to be taken.
%  theta - Parameter determining the two-step method used.
%
% Output:
%  x_all - The computed x values for every step taken.
%
% A stepper is responsible for iterating over the steps of a numerical method.
% This particular stepper is an explicit two-step method with a constant step
% size.
%------------------------------------------------------------------------------
    
    % Make sure that the initial value vector is on the right form.
    x_0 = reshape(x_0, [], 1);

    % Compute the step size.
    h = (t_n - t_0) / n;

    % Compute the coefficients of the method.
    neg_alphas = - [coeffs.alpha1(1, theta); coeffs.alpha0(1, theta)];
    betas      = [coeffs.beta1(1, theta);  coeffs.beta0(1, theta)];

    % Prepare the intial values.
    xs  = init_two_step(f, x_0, t_0, h);
    dxs = [f(t_0+h, xs(:,1)) f(t_0, xs(:,2))];
    t         = t_0 + h;

    % Allocate memory for storing the solutions and save the first values.
    x_all      = zeros(n+1,length(x_0));
    x_all(1:2,:) = fliplr(xs)';

    % Iteration to compute the solution.
    for i = 2:n

        % Compute the new values
        x_new = gelmm(xs, dxs, h, neg_alphas, betas);
        t     = t + h;

        % Update the solution vector.
        xs         = [x_new xs(:,1:(end-1))];
        dxs        = [f(t, x_new) dxs(:, 1:(end-1))];

        % Store the computed value to be returned.
        x_all(i+1,:) = x_new;
    end