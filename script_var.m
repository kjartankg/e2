thetas = linspace(pi/4, pi, 128);

%remove boundaries
thetas = thetas(2:(end - 1));

problem   = @problems.oscillatory;
exact_sol = @problems.oscillatory_exact;
x_start   = 1;
t_start   = 0;
t_end     = 15;
tol       = 1e-6;
file_name = 'data/var_grid2.mat';

mge      = zeros(length(thetas));
nr_steps = zeros(length(thetas));

for main = 1:length(thetas)
    for err = 1:length(thetas)
        if main == err
            continue
        end
        data = stepper_var_step_const_c(problem, x_start, t_start, t_end, tol, thetas(main), thetas(err));

        ex_sol = zeros(1, length(data.t_all));
        for j = 1:length(ex_sol)
            ex_sol(j) = exact_sol(data.t_all(j));
        end
        mge(err,main) = sum(abs(data.x_all(2:end)' - ex_sol(2:end)))/length(data.t_all(2:end));
        nr_steps(err,main) = length(data.t_all) - 1;
    end
    main
end

save(file_name, 'mge', 'nr_steps');