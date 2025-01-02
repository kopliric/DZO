fig = 0;

%% Show spectrum of common 2D signals 

%constant signal
x = image_generator('constant',[128,128],1); 
X = fft2(x); 

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Constant signal')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Constant signal magnitude spectrum')

%harmonic signal (horizontal frequency only)
x = image_generator('harmonic',[128,128], 20*pi/128, 0*pi/128, 0); 
X = fft2(x); 

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Harmonic signal')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Harmonic signal magnitude spectrum')

%harmonic signal (horizontal and vertical frequency only)
x = image_generator('harmonic',[128,128], 20*pi/128, 40*pi/128, 0); 
X = fft2(x); 

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Harmonic signal')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Harmonic signal magnitude spectrum')

%harmonic signal (Nyquist frequency)
x = image_generator('harmonic',[128,128], pi, pi, 0); 
X = fft2(x); 

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Harmonic signal at Nyquist frequency')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Harmonic signal magnitude spectrum')

%square
x = image_generator('square',[512,512],10);
X = fft2(x);

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Square')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Square magnitude spectrum')

%circ
x = image_generator('circ',[512,512],15);
X = fft2(x);

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Circ')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Circ magnitude spectrum')

%Gaussian
x = image_generator('Gaussian',[512,512],5);
X = fft2(x);

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Gaussian')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Gaussian magnitude spectrum')

%Gaussian with a wider support
x = image_generator('Gaussian',[512,512],50);
X = fft2(x);

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Gaussian')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Gaussian magnitude spectrum')

%Gabor filter
x = image_generator('Gabor',[512,512],0.15*pi, 0.1*pi, 50);
X = fft2(x);

fig=fig+1; figure(fig); imagesc(x); colormap gray; axis image; title('Gabor')
fig=fig+1; figure(fig); show_spectrum(X,'gray'); title('Gabor magnitude spectrum')

%% Spectrum of a photo, importance of a phase spectrum

x0 = imread('Lenna.png');
x0 = double(sum(x0,3)/3);

X0 = fft2(x0);

% same magnitude, constant (zero) phase
mag1 = abs(X0);
phase1 = 0;
X1 = mag1 .* exp(1i*phase1);
x1 = real(ifft2(X1)); %inverse fft (result is an image)

% constant (1) magnitude, same phase
mag2 = 1;
phase2 = angle(X0);
X2 = mag2 .* exp(1i*phase2);
x2 = real(ifft2(X2)); %inverse fft (result is an image)

fig = fig+1;
figure(fig);
image(x0); colormap gray; 
axis image; title('Input image');

fig = fig+1;
figure(fig);
show_spectrum(X0,'gray');
axis image; title('Magnitude spectrum');

fig = fig+1;
figure(fig);
imagesc(x1); set(gca,'clim',[0,255]); colormap gray
axis image; title('Reconstructed image - Altered spectrum phase');

fig = fig+1;
figure(fig);
imagesc(x2); colormap gray
axis image; title('Reconstraucted image - Altered spectrum magnitude');

%% Spectrum of translated/rotated image

x = imread('A_black.png'); 

fig = fig+1; figure(fig); 
imagesc(x); colormap gray; title('Input image');
axis image;

X = fft2(x); 

fig = fig+1; figure(fig); 
show_spectrum(X,'gray'); title('Magnitude spectrum');
axis image;

% Translate the image by 100px horizontally and by 50 px vertically, show
% the image and the magnitude spectrum
dx = 100;
dy = 50;
x_t = imtranslate(x,[dx,dy]);

fig = fig+1; figure(fig)
imagesc(x_t); colormap gray; title('Input image')
axis image

X_t = fft2(x_t);

fig = fig+1; figure(fig); 
show_spectrum(X_t,'gray'); title('Magnitude spectrum');
axis image;

% Rotate the image by 90 degrees counterclockwise, show the image and the
% magnitude spectrum 
alpha = 90;
x_r = imrotate(x,alpha,'crop');

fig = fig+1; figure(fig)
imagesc(x_r); colormap gray; title('Input image')
axis image

X_r = fft2(x_r);

fig = fig+1; figure(fig); 
show_spectrum(X_r,'gray'); title('Magnitude spectrum');
axis image;

% Rotate the image by 45 degrees clockwise, show the image and the
% magnitude spectrum  - Use rotated image "A_black_45.png"
x_r45 = imread("A_black_45.png");

fig = fig+1; figure(fig)
imagesc(x_r45); colormap gray; title('Input image')
axis image

X_r45 = fft2(x_r45);

fig = fig+1; figure(fig); 
show_spectrum(X_r45,'gray'); title('Magnitude spectrum');
axis image;

%% Low/high pass filtering in frequency domain (OPTIONAL)

x = imread('Lenna.png');
x = double(sum(x,3)/3);

fig = fig+1; figure(fig);
image(x); colormap gray; 
axis image; title('Input image');

X = fft2(x); 

fig = fig+1; figure(fig); 
show_spectrum(X,'gray'); cl = get(gca, 'clim'); 
axis image; title('Magnitude spectrum');

X = fftshift(X);

%low pass
G = image_generator('Gaussian',size(x),20);
Yg = X .* G;
Yg = ifftshift(Yg); % low-pass filtered spectrum

% %high pass
H = image_generator('circ',size(x),(size(x,1)/2)/8);
H = ~H;
Yh = X .* H;
Yh = ifftshift(Yh); % high-pass filtered spectrum

%low pass
fig = fig+1; figure(fig); 
imagesc(G); colormap('gray')
axis image; title('Gaussian Filter in frequency domain')

fig = fig+1; figure(fig); 
show_spectrum(Yg,'gray',cl);
axis image; title('Filtered magnitude spectrum (Low-pass)'); 

yg = real(ifft2(Yg));

fig = fig+1; figure(fig); 
image(yg); colormap gray
axis image; title('Low-pass filtered image');

% high pass 
fig = fig+1; figure(fig); 
imagesc(H); colormap gray
axis image; title('High-pass filter in frequency domain')

fig = fig+1;figure(fig); 
show_spectrum(Yh,'gray',cl);
axis image; title('Filtered magnitude spectrum (High-pass)'); 

yh = real(ifft2(Yh));

fig = fig+1; figure(fig); 
image(yh); colormap gray
axis image; title('High-pass filtered image');
