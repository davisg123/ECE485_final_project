function [y] = add_mismatch(a,b)

dif = length(a) - length(b);

if (dif < 0)
    a_new = cat(2,a,zeros(1,abs(dif)));
    b_new = b;
else
    b_new = cat(2,b,zeros(1,dif));
    a_new = a;
end

y = a_new + b_new;