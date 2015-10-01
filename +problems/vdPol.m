function dx = vdPol(t, x)
    mu = 10;
    dx = [x(2); mu * (1 - x(1)^2) * x(2) - x(1)];
end