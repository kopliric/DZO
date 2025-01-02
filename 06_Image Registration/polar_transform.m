function [im_transformed, r, phi] = polar_transform(im, cx, cy, H)
% function polar_transform(im, cx, cy, H)
% cx, cy = center of transformation 
% H = radius (max distance from center of transformation) for which
% transformation should be computed
%
% im_transformed: transformed image. 
% r: 1-by-M vector specifying radius values along x coordinate.
% phi: 1-by-N vector specifying phi values along y coordinates. 

numPhi = ceil(2*pi*H);
numR = H;

r = linspace(1, H, numR);
phi = linspace(1/H, 2*pi, numPhi);

[R, Phi] = ndgrid(r, phi);

X = cx + R .* cos(Phi);
Y = cy + R .* sin(Phi);

im_transformed = interp2(double(im), X, Y);
im_transformed = im_transformed';