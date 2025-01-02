function val = bilinear(im, x, y, blank_val) 
% function val = bilinear(im, x, y, blank_val) 
% for image im and coordinates x, y, the function 
% outputs value val using bi-linear interpolation. 
% If the coordinates x, y are out of range
% then it sets val=blank_val. 

[M,N] = size(im);
in_range = @(x,y) x>=1 && x<=N-1 && y>=1 && y<=M-1;

x_ = floor(x);
y_ = floor(y);

dx = x - x_;
dy = y - y_;

if in_range(x_, y_)
    I0 = im(y_, x_);
    I1 = im(y_, x_+1);
    I2 = im(y_+1, x_);
    I3 = im(y_+1, x_+1);

    val = (I0 * (1 - dx) + I1 * dx) * (1 - dy) + (I2 * (1 - dx) + I3 * dx) * dy;
else 
    val = blank_val;
end
    