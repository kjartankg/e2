function dx = kepler(t,x)
    dv = - x(1:2)/norm(x(1:2))^3;
    dx = [x(3); x(4); dv(1); dv(2)];
end