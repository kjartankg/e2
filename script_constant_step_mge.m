%------------------------------------------------------------------------------
% List of problems:
%    logistic_curve, logistic_exact, x_0 = 1, t_0 = 0, t_n = 20
%    neg_exp, neg_exp_exact,         x_0 = 1, t_0 = 0, t_n = 3
%    oscillatory, oscillatory_exact, x_0 = 1, t_0 = 0, t_n = 4*pi
%    riccati, riccati_exact,         x_0 = 1, t_0 = 0, t_n = 6
%------------------------------------------------------------------------------
thetas = linspace(pi/4,pi,500);

problem   = @problems.riccati;
exact_sol = @problems.riccati_exact;
x_start   = 1;
t_start   = 0;
t_end     = 6;
file_name = 'data/riccati_err.mat';

mge = zeros(8, length(thetas));

for k = 4:11
    n = 2^k;
    h = (t_end - t_start) / n;
    ex_sol = zeros(1,n+1);
    for j = 1:length(ex_sol)
        ex_sol(j) = exact_sol(t_start+(j-1)*h);
    end
    for j = 1:length(thetas)
         sol = stepper_const_step(problem, x_start, t_start, t_end, n, thetas(j));
         mge(k-3,j) = sum(abs(sol(2:end)' - ex_sol(2:end)))/n;
    end
    k
end

save(file_name,'mge');
