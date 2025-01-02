% DZO - Introduction to MATLAB
% author: Richard Köplinger
% date: 2023-02-22

%% download image
I = imread('https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png');

%display image
figure(1); image(I); axis image
title('Input Image')

%% crop the image by 50 pixels on each side
c = 50;
Ic = I(c+1:end-c,c+1:end-c,:);

%display image
figure(2); image(Ic); axis image
title('Cropped image')
size(Ic)

%% convert image to grayscale 

% GrayScale = 0.2989 * R + 0.5870 * G + 0.1140 * B;
J = 0.2989 * Ic(:,:,1) + 0.5870 * Ic(:,:,2) + 0.1140 * Ic(:,:,3);
J = uint8(J);

% Create 3-channel grayscale images (same value for all channels)
K = cat(3,J,J,J);
K = uint8(K);

%display image
figure(3); image(K); axis image;
title('Grayscale image')

%% Highlight high/low intensity pixels

%- show high intensity pixels in red (I>200);
%- show low intensity in blue (I<50); 

L = K;

% high intensity
[r,c] = find(K(:,:,1) > 200);

for i = 1:length(r)
    L(r(i),c(i),1) = 255;
end
for j = 2:3
    for i = 1:length(r)
        L(r(i),c(i),j) = 0;
    end
end

% low intensity
[r,c] = find(K(:,:,1) < 50);

for i = 1:length(r)
    L(r(i),c(i),3) = 255;
end
for j = 1:2
    for i = 1:length(r)
        L(r(i),c(i),j) = 0;
    end
end

%display image
figure(4); image(L); axis image
title('Intensity highlighted image')

%% Add a yellow 10px-thick border around the resulting image

% yellow sqare
b = 10;
s = size(L(:,:,1)) + 2*b;
M = 255 * ones(s);
M(:,:,2) = 255 * ones(s);
M(:,:,3) = zeros(s);

M = uint8(M);

% add image into the yellow sqaure
M(b+1:end-b,b+1:end-b,:) = L;

figure(5); image(M); axis image
% size(M);
title('Image with a yellow border');

%store the image as JPEG
imwrite(M,'result.jpg')

%read from disk
N = imread('result.jpg');
figure(6); image(N); axis image
title('Image result read from disk')
