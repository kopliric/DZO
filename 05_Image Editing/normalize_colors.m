function O = normalize_colors(I)
 
O = I - min(min(I));
O = O ./ max(max(O));
end