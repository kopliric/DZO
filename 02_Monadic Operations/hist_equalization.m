function eq_img = hist_equalization(img)
% FUNCTION NAME:
%   hist_equalization
%
% DESCRIPTION:
%   function for histogram equalization of an image
%
% INPUT:
%   img - image in gray-scale as a float type in range [0,1]
%
% OUTPUT:
%   eq_img - equalized image of a float type in range [0,1]

    intensity_levels = 256;

    % compute the image CDF
    img_cdf = compute_cdf(img, intensity_levels);

    % equalize the image
    img = img * (intensity_levels-1);
    eq_img = img_cdf(img + 1);
   
end