function z = ZDT1(x)
    n = numel(x);
    
    % Hàm f1
    f1 = x(1);
    
    % Hàm g: g = 1 + 9 * sum(x(2:end)) / (n - 1)
    g = 1 + 9 * sum(x(2:end)) / (n - 1);
    
    % Hàm h
    h = 1 - sqrt(f1 / g);
    
    % Hàm f2
    f2 = g * h;
    
    z = [f1, f2];
end
