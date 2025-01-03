function [M]=show_spectrum(X, cmap, clim)
% SHOW_SPECTRUM - shows a magnitude spectrum of an image
%
% [M] = show_spectrum(X, cmap, clim)
%
%   X - input frequency spectrum (output of FFT2)
%   cmap - string {'gray','jet',etc.} (default is jet)
%   clim - [min, max] the range that is mapped to the range of the colormap
%
%   M - output image (same size as X) containing rescaled magnitude
%       spectrum
%

X_shifted = fftshift(X);
magX = abs(X_shifted);
eps_val = 1;
magX = magX + eps_val;
M = 20*log10(magX);

imagesc(M);
axis image; 

if ~exist('cmap','var') || isempty(cmap)
    cmap = 'jet';
end

if ~exist('clim','var') || isempty(clim)
    clim = get(gca,'clim');
end

colormap(cmap)
set(gca,'clim',clim);
