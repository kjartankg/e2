function dx = lotka_volterra(t, x)
    global a b c d
    a = 3;
    b = 9;
    c = 15;
    d = 15;

    dx = [a*x(1) - b*x(1)*x(2); c*x(1)*x(2) - d*x(2)];
end