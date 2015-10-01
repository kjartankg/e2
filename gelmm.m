function x_new = gelmm(xs, dxs, h, neg_alphas, betas)
%------------------------------------------------------------------------------
% Inputs:
%  xs           - Solutions to the k last iterations in a vector.
%  dxs          - The deriviatives of the solutions xs.
%  h            - The step size.
%  neg_alphas   - The negative alpha coefficients.
%  betas        - The beta coefficients
%
% Output:
%  y_new - The computed x values for every step taken.
%
% A general explicit linear k-step method. Computes explicitly the next step,
% given the values and coefficients needed.
%------------------------------------------------------------------------------
    x_new = xs * neg_alphas + h * (dxs * betas);
end