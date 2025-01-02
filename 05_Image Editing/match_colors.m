function O = match_colors(A, M, I)

O = zeros(size(A));

shift_color = zeros(1,3);
px_counter = zeros(1,3);

for c = 1:3
    [x,y] = find(M(:,:,c) == 0);
    px_counter(c) = length(x);
    for i = 1:length(x)
        shift_color(c) = shift_color(c) + A(x(i), y(i), c) - I(x(i), y(i), c);
    end
end

shift_color = shift_color ./ px_counter;

for c = 1:3
    O(:,:,c) = I(:,:,c) + shift_color(c);
end

end