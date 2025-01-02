function [img_cdf] = compute_cdf(img, intensity_levels)
% FUNCTION NAME:
%   compute_cdf
%
% DESCRIPTION:
%   computes cummulative distribution function (CDF) of an image with gray
%   levels in the range [0,intensity_levels] normalizes it into range [0,1]
%
% INPUT:
%   img - image as a float type in range [0,1]
%   intensity_levels - number of gray levels in the images incremented by 1
%       default is 256
%
% OUTPUT:
%   img_cdf - computed CDF of img as a 1D array normalized to
%   range [0,1]

    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    img_cdf = zeros(intensity_levels, 1);
    
    img_hist = compute_hist(img, intensity_levels);
    img_cdf(1) = img_hist(1);
    for i = 2:intensity_levels
        img_cdf(i) = img_hist(i) + img_cdf(i-1);
    end

end