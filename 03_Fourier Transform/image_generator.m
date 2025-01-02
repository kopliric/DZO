function [I] = image_generator(sig_type, imsize, varargin)
% IMAGE_GENERATOR - generates 2d signals
%
% [I] = image_generator(sig_type, params)
%   
%   sig_type - string {'constant','harmonic','square','circ','Gaussian','Gabor'}
%   params - list of parameters depending on signal type    
%       'constant':  a (dc component)
%       'harmonic':  u,v,phi (horizontal and vertical frequency in range 0..pi, pi is the Nyquist frequency, phase 0..pi)
%       'square':  s (half-side of the square in pixels)
%       'circ':    r (radius of the circle in pixels)
%       'Gaussian': sigma (standard deviation in pixels)
%       'Gabor': u0,v0,sigma (normalized horizontal,vertical frequency 0..pi, standard deviation)
%
% Example: 
%   I = image_genrator('Gaussian',[512,512],20);
%

I = zeros(imsize); %init (in case something is not implemented)
height = imsize(1);
width = imsize(2);

switch sig_type
    case 'constant'  %a
        a = varargin{1};
        I = a*ones(imsize);
    case 'harmonic'  %u, v, phi
        u = varargin{1}; v = varargin{2}; phi = varargin{3};
        [x,y] = meshgrid(1:width, 1:height);
        I = cos(u*x + v*y + phi);
    case 'square'    %s
        s = varargin{1};
        start_x = floor(width/2) - s;
        end_x = start_x + 2*s - 1;
        start_y = floor(height/2) - s;
        end_y = start_x + 2*s - 1;
        I(start_y:end_y, start_x:end_x) = 1;
    case 'circ'      %r
        r = varargin{1};
        [x,y] = meshgrid(1:width, 1:height);
        distance = sqrt((x - width/2).^2 + (y - height/2).^2);
        I = distance <= r;
    case 'Gaussian'  %sigma
        sigma = varargin{1};
        [x,y] = meshgrid(1:width,1:height);
        Xc = ceil(width/2);
        Yc = ceil(height/2);
        x = x - Xc;
        y = y - Yc;
        I = exp(-(x.^2 + y.^2)/(2*sigma^2));
    case 'Gabor'     %u0,v0,sigma  (OPTIONAL)
        u0 = varargin{1}; v0 = varargin{2}; sigma = varargin{3};
        [x,y] = meshgrid(-(width-1)/2:(width-1)/2, -(height-1)/2:(height-1)/2);
        I = exp(-(x.^2+y.^2)/(2*sigma^2)).*cos(u0*x + v0*y);
    otherwise
        error('Unknown signal type.')
end
