theta = 2.9;
eta   = 2.85;

problem   = @problems.vdPol;
x_start   = [2 0];
t_start   = 0;
t_end     = 60;
tols      = [1e-5 1e-6 1e-7 1e-8 1e-9];
file_name = 'data/vdPol.mat';

msge     = zeros(1, length(tols));
nr_steps = zeros(1, length(tols));

options1 = odeset('RelTol', 1e-12, 'AbsTol', 1e-15);

for ii = 1:length(tols)
    data = stepper_var_step_const_c(problem, x_start, t_start, t_end, tols(ii), theta, eta);
    [T, Y] = ode113(problem, data.t_all', x_start, options1);
    
    msge(ii) =  sum(sum((Y - data.x_all).^2,2).*data.h_all);
    nr_steps(ii) = length(data.t_all);
end


save(file_name, 'msge', 'nr_steps');