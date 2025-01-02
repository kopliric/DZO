function O = solve_FT(divG)
 
w = size(divG, 1);
h = size(divG, 2);

O = zeros(w, h, 3);

l = [0 1 0; 
     1 -4 1; 
     0 1 0];

L = fft2(l, w, h);

lambda = 1e-10;

for c = 1:3
    DIVG_c = fft2(divG(:, :, c));
    O_c = (conj(L).*DIVG_c)./(abs(L).^2 + lambda);
    O(:, :, c) = ifft2(O_c);
end

end