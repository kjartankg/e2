
theta = pi/2;

problem   = @problems.kepler;
x_start   = [1 0 0 -1.4];
t_start   = 0;
t_end     = 10;
n         = 100;
%file_name = '../data/const_step/riccati_err.mat';


sol = stepper_const_step(problem, x_start, t_start, t_end, n, theta);

