function img_matched = match_hists(img, img_target, intensity_levels)
% FUNCTION NAME:
%   match_hists
%
% DESCRIPTION:
%   function for histogram matching of two images
%
% INPUT:
%   img - grayscale image to transform, as a float type in range [0,1]
%   img_target - grayscale image with reference histogram, as a float type in range [0,1]
%   intenity_levels - number of gray levels in the images incremented by 1
%       default is 256
%
% OUTPUT:
%   img_matched - img matched to a referenced histogram of img_target

    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    % get both CDFs
    img_cdf = compute_cdf(img,intensity_levels);
    target_cdf = compute_cdf(img_target,intensity_levels);
    
    % create histogram matching lookup table
    matching_lut = zeros(intensity_levels, 1);

    for idx = 1:intensity_levels
        [~,intensity] = min(abs(img_cdf(idx) - target_cdf));
        matching_lut(idx) = intensity - 1;
    end
    
    % match the histograms
    img = img * (intensity_levels - 1);
    img_matched = matching_lut(img+1);
    img_matched = img_matched / (intensity_levels - 1);

end
