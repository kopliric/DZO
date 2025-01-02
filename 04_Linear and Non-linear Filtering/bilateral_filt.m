function image_out = bilateral_filt( image, ksize, space_stddev, intensity_stddev )
%BILATERAL Implementation of a bilateral filter using Gaussian functions
% image:
%   the input (noisy) grayscale image (2D array)
% ksize:
%   size of the filtering window (1x2 matrix)
% space_stddev:
%   standard deviation of the Gaussian over pixel distances
% intensity_stddev:
%   standard deviation of the Gaussian over pixel value distances

%% 5: implemented Bilateral filter
% - go through all image (x,y) and filter window (s,t) coordinates
%   - do the DC padding as in your convolution_2D implementation
% - for each coordinate quadruple (x,y,s,t) compute the space weight
%   - Gaussian "G" over the distance of the current pixel (defined by 
%     (x,y,s,t)) from the window center pixel (x,y)
% - for each coordinate quadruple (x,y,s,t) compute the intensity weight
%   - Gaussian "b" over the difference of the pixel values at the current
%     pixel (defined by (x,y,s,t)) and the pixel at the window center (x,y)
% - multiply the weights and the current pixel and sum these over
%   the window
% - normalize each output pixel by the sum of the corresponding weights

image_out = zeros(size(image));

% spatial Gaussian filter
[x,y] = meshgrid(-floor(ksize(2)/2):floor(ksize(2)/2), -floor(ksize(1)/2):floor(ksize(1)/2));
G = exp(-(x.^2 + y.^2) / (space_stddev^2));

% DC padding
pad_size_y = floor(ksize(1)/2);
pad_size_x = floor(ksize(2)/2);
padded_img = padarray(image, [pad_size_y pad_size_x], 'replicate', 'both');

for y = 1:size(image,1)
    for x = 1:size(image,2)
        region = padded_img(y:y + ksize(1) - 1, x:x + ksize(2) - 1);
        center_px = image(y,x);
        b = exp(-((center_px - region).^2) / (intensity_stddev^2)); % intensity Gaussian filter
        
        % bilateral filtering
        bilateral_kernel = G .* b;
        image_out(y,x) = sum(sum(bilateral_kernel .* region)) / sum(sum(bilateral_kernel));
    end
end

end
