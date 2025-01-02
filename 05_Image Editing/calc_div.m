function [divG] = calc_div(Gx, Gy)

Gx = padarray(Gx,[1 0 0], 0, 'pre');
Gy = padarray(Gy,[0 1 0], 0, 'pre');

divG = diff(Gx,1,1) + diff(Gy,1,2);

end