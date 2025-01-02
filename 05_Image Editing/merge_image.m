function O = merge_image(A, B, M)

w = size(A, 1);
h = size(A, 2);

O = zeros(w, h, 3);

for x = 1 : w
    for y = 1 : h
        if M(x, y) == 0
            O(x, y, :) = A(x, y, :);
        else
            O(x, y, :) = B(x, y, :);
        end
    end
end

end