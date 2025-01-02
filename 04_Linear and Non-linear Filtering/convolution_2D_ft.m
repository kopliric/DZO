function image_out = convolution_2D_ft(image, kernel)
%CONVOLUTION_2D_FT 2D convolution using Fourier Transform
% image:
%   the input grayscale image (2D array)
% kernel:
%   the convolutional kernel (2D array)

%% 2: implemented convolution using Fourier transform
[img_h, img_w] = size(image);
[ker_h, ker_w] = size(kernel);
out_h = img_h + ker_h - 1;
out_w = img_w + ker_w - 1;

image_out = ifft2(fft2(image, out_h, out_w) .* fft2(kernel, out_h, out_w));
image_out = image_out(1:out_h, 1:out_w);

end
