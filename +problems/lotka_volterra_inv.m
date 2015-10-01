function H = lotka_volterra_inv(x)
    global a b c d 
    H = c*x(:,1) + b*x(:,2) - d*log(x(:,1)) - a*log(x(:,2));
end