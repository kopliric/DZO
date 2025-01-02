function [img_hist] = compute_hist(img, intensity_levels)
% FUNCTION NAME:
%   compute_hist
%
% DESCRIPTION:
%   computes histogram of an image with gray levels in the range
%   [0,intensity_levels] and normalizes it into range [0,1]
%
% INPUT:
%   img - image as a float type in range [0,1]
%   intensity_levels - number of gray levels in the images incremented by 1
%       default is 256
%
% OUTPUT:
%   img_hist - computed and histogram of img as a 1D array normalized to
%   range [0,1]

    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    img_hist = zeros(intensity_levels, 1);

    img = round(img * (intensity_levels-1));
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            idx = img(i,j) + 1;
            img_hist(idx) = img_hist(idx) + 1;
        end
    end
    
    img_hist = img_hist / sum(img_hist);

end