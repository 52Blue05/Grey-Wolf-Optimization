function f = ZDT1(x)

n = numel(x);
f1 = x(1);

g = 1 + 9 * sum(x(2:n)) / (n-1);

h = 1 - sqrt(f1/g);

f2 = g * h;

f = [f1 f2];
end
