theta = 2.9;
eta   = 2.85;

problem   = @problems.lotka_volterra;
H         = @problems.lotka_volterra_inv;
x_start   = [1 1];
t_start   = 0;
t_end     = 5;
tols      = [1e-6 1e-7 1e-8 1e-9 1e-10];
file_name = 'data/lotka_volterra.mat';

msge     = zeros(1, length(tols));
nr_steps = zeros(1, length(tols));
H_err    = cell(5,1);
ts       = cell(5,1);

options1 = odeset('RelTol', 1e-13, 'AbsTol', 1e-16);

for ii = 1:length(tols)
    data = stepper_var_step_const_c(problem, x_start, t_start, t_end, tols(ii), theta, eta);
    [T, Y] = ode113(problem, data.t_all', x_start, options1);
    
    msge(ii)     = sum(sum((Y - data.x_all).^2,2).*data.h_all);
    nr_steps(ii) = length(data.t_all);
    H_err{ii}    = abs(H(data.x_all(2:end,:))/H(data.x_all(1,:)) - 1);
    ts{ii}       = data.t_all';
end


save(file_name, 'msge', 'nr_steps', 'H_err', 'ts');