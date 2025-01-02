function image_out = wiener_filt(image, kernel, lambda)
%WIENER_FILT Wiener filtration
% image:
%   the input (blurred) grayscale image (2D array)
% kernel:
%   the convolutional kernel (2D array) which is causing the blur
% lambda:
%   parameter preventing the division by zero

% 4: implemented Wiener filter
% - transform both the image and the kernel into frequency domain, apply
%   the formula for the estimation of the unblured image and transform
%   the result back to the spatial domain

IMG = fft2(image);
KER = fft2(kernel, size(image,1), size(image, 2));
KER_PS = abs(KER).^2; % power spectrum of kernel

IMG_OUT = (conj(KER) .* IMG) ./ (KER_PS + lambda);
image_out = real(ifft2(IMG_OUT));
image_out = abs(image_out);

end
