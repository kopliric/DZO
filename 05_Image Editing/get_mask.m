function M = get_mask(GxA, GyA, GxB, GyB)

w = size(GxA, 1);
h = size(GxA, 2);

M = zeros(w, h, 3);

c = 1:3;
for x = 1 : w
    for y = 1 : h
        maGxA = sqrt(sum(GxA(x, y, c).^2));
        maGyA = sqrt(sum(GyA(x, y, c).^2));
        maGxB = sqrt(sum(GxB(x, y, c).^2));
        maGyB = sqrt(sum(GyB(x, y, c).^2));

        if (maGxA > maGxB && maGxA > maGyB) || (maGyA > maGxB && maGyA > maGyB)
            M(x, y, :) = zeros(1,3);
        else
            M(x, y, :) = ones(1,3);
        end
    end
end
end