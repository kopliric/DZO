function im2_registered = register(im1, im2) 
% function im2_registered = register(im1, im2) 

% preallocate array to store registered image
[M,N] = size(im2);
im2_registered = zeros(M,N);

% compute magnitude spectra of images
mag1 = abs(fft2(im1));
mag1 = fftshift(mag1);
mag1 = log(10+mag1);

mag2 = abs(fft2(im2));
mag2 = fftshift(mag2);
mag2 = log(10+mag2);

% choose center and radius of polar transformation
[cx1, cy1] = ffcenter(mag1);
[cx2, cy2] = ffcenter(mag2);
H = cx2-2;

% tranform spectra from cartesian to polar coordinates
[mag1_pol, ~, ~] = polar_transform(mag1, cx1, cy1, H);
[mag2_pol, ~, phi_pol_2] = polar_transform(mag2, cx2, cy2, H);

% find shift in phase
[~, sy] = phase_corr(mag1_pol, mag2_pol);
phi = phi_pol_2(abs(sy))-pi;

if sy > 0
    phi = -phi;
end

% choose center of rotation for im2
cx = floor(N/2)+1;
cy = floor(M/2)+1;

% preallocate array to store rotated image
im2_rot = zeros(M,N);

% rotate
for x = 1:N
    for y = 1:M
        [x_, y_] = rotation(x, y, phi, cx, cy);
        im2_rot(y,x) = bilinear(im2, x_, y_, 0);
    end
end

% find shift in x and y coordinates
[sx, sy] = phase_corr(im1, im2_rot);

% translate
for x = 1:N
    for y = 1:M
        [x_, y_] = translation(x, y, -sx, -sy);
        im2_registered(y,x) = bilinear(im2_rot, x_, y_, 0);
    end
end
end
