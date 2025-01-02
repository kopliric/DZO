function image_out = convolution_2D(image, kernel)
%CONVOLUTION_2D 2D convolution between an image and kernel
% image:
%   the input grayscale image (2D array)
% kernel:
%   the convolutional kernel (2D array)

%% 1a: implemented brute-force convolution using loops
% - implemented "DC" padding
%   - for the pixels in areas, where the kernel would look outside of 
%     the original image, use the nearest image pixel (clip the coordinates)

image_out = zeros(size(image));

% DC padding
pad_size_y = floor(size(kernel,1)/2);
pad_size_x = floor(size(kernel,2)/2);
padded_img = padarray(image, [pad_size_y pad_size_x], 'replicate', 'both');

% filtering of the image
for y = 1:size(image, 1)
    for x = 1:size(image, 2)
        region = padded_img(y:y + size(kernel,1) - 1, x:x + size(kernel,2) - 1);
        image_out(y,x) = sum(sum(kernel .* region));
    end
end
        
end
