function O = solve_GS(A, divG)

w = size(A, 1);
h = size(A, 2);

O = A;

for i = 1 : 500    % number of iterations
    for x = 2 : w - 1
        for y = 2 : h - 1
            for c = 1 : 3
                O(x, y, c) = ( O(x + 1, y, c) + O(x - 1, y, c) + ...
                               O(x, y + 1, c) + O(x, y - 1, c) - ...
                               divG(x, y, c)) / 4;
            end
        end
    end
end

end
