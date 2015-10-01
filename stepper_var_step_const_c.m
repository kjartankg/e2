function [data] = stepper_var_step_const_c(f, x_0, t_0, t_n, tol, theta, eta)
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
%  data - The computed x values for every step taken.
%
% A stepper is responsible for iterating over the steps of a numerical method.
% This particular stepper is an explicit two-step method with variable step
% size using an error constant that is not varied with respect to the step
% size ratio.
%------------------------------------------------------------------------------

    % Make sure that the initial value vector is on the right form.
    x_0 = reshape(x_0, [], 1);

    % Initial values setup.
    h   = abs(t_n - t_0)*tol^(1/2) / (100. * (1 + norm(f(t_0, x_0))));
    r   = 1;
    xs  = init_two_step(f, x_0, t_0, h);
    dxs = [f(t_0+h, xs(:,1)) f(t_0, xs(:,2))];
    t   = t_0+h;

    % Calculate the error constants for the given step.
    c     = err.error_constant(1, theta);
    c_err = err.error_constant(1, eta);

    % Init return value arrays.
    est_nr_steps = uint64(abs(t_n - t_0)/h * 2);
    x_all        = zeros(est_nr_steps, length(x_0));
    dx_all       = zeros(est_nr_steps, length(x_0));
    t_all        = zeros(est_nr_steps, 1);
    h_all        = zeros(est_nr_steps, 1);
    r_all        = zeros(est_nr_steps, 1);
    est_err_all  = zeros(est_nr_steps, 1);

    % Put first values into the storage arrays.
    x_all(1:2,:)  = fliplr(xs)';
    dx_all(1:2,:) = fliplr(dxs)';
    t_all(1:2)    = [t_0 t];
    h_all(2)      = h;
    r_all(2)      = r;

    % Initializing the boolean for the while loop and the step counter.
    isNotDone = 1;
    step      = 2;

    % Something something
    while isNotDone

        step = step + 1;

        % Check if this is the last step else use the step size ratio computed.
        if t_n < t + h * r
            h_end     = t_n - t;
            r         = h_end / h;
            h         = h_end;
            isNotDone = 0;
        else
            h = h * r;
        end

        % Calculate the coefficients for the given step.
        neg_alphas     = - [coeffs.alpha1(r, theta); coeffs.alpha0(r, theta)];
        betas          = [coeffs.beta1(r, theta); coeffs.beta0(r, theta)];

        neg_alphas_err = - [coeffs.alpha1(r, eta); coeffs.alpha0(r, eta)];
        betas_err      = [coeffs.beta1(r, eta); coeffs.beta0(r, eta)];

        % Calculating new values.
        x_new = gelmm(xs, dxs, h, neg_alphas, betas);
        x_err = gelmm(xs, dxs, h, neg_alphas_err, betas_err);
        t     = t + h;

        % Updating the variables
        xs  = [x_new xs(:,1:(end-1))];
        dxs = [f(t, x_new) dxs(:, 1:(end-1))];

        % Storing the data
        x_all(step,:)  = x_new';
        dx_all(step,:) = dxs(:,1)';
        t_all(step)    = t;
        h_all(step)    = h;
        r_all(step)    = r;

        % Calculating next step size.
        est_err = err.error_estimate(c, c_err, x_new, x_err);
        r       = err.step_control(tol, est_err, r, 2);
        r       = err.upper_limit(r, [theta, eta]);

        % Store the estimated error.
        est_err_all(step)  = est_err;
    end

    % Cut away extra space in the storing arrays if any and embad in the data
    % variable.
    data.x_all  = x_all(1:step,:);
    data.dx_all = dx_all(1:step,:);
    data.t_all  = t_all(1:step);
    data.h_all  = h_all(1:step);
    data.r_all  = r_all(1:step);
    data.est_err_all = est_err_all(1:step);
end