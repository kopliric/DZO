function [Gx, Gy] = merge_grad(GxA, GyA, GxB, GyB, M)

w = size(GxA, 1);
h = size(GxA, 2);

Gx = zeros(w, h, 3);
Gy = zeros(w, h, 3);

for x = 1 : w
    for y = 1 : h
        if M(x, y) == 0
            Gx(x, y, :) = GxA(x, y, :);
            Gy(x, y, :) = GyA(x, y, :);
        else
            Gx(x, y, :) = GxB(x, y, :);
            Gy(x, y, :) = GyB(x, y, :);
        end
    end
end

end