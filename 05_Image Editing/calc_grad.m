function [Gx, Gy] = calc_grad(I)

w = size(I,1);
h = size(I,2);

Gx = zeros(w, h, 3);
Gy = zeros(w, h, 3);

for y=1:h-1
    for x=1:w-1
        for c=1:3
            Gx(x,y,c) = I(x + 1, y, c) - I(x, y, c);
            Gy(x,y,c) = I(x, y + 1, c) - I(x, y, c);
        end % c
    end % x
end % y

end
