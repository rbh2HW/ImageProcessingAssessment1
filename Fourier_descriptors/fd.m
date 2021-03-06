
clear all
close all

%
I = imread('electron_micrograph_of_a_human_chromosome.jpg');
figure, imshow(I);
pause;
%
I = 1-im2double(I);
h = fspecial('gaussian',25,15);
I = imfilter(I,h,'replicate');
I = im2bw(I,1.7*graythresh(I));
figure, imshow(I);
pause;
%
% Find a starting point on the boundary
[rows cols] = find(I~=0);

contour = bwtraceboundary(I, [rows(1), cols(1)], 'N');

% Subsample the boundary points so we have exactly 128, and put them into a
% complex number format (x + jy)
sampleFactor = length(contour)/128;
dist = 1;
for i=1:128
    c(i) = contour(round(dist),2) + j*contour(round(dist),1);
    dist = dist + sampleFactor;
end

C = fft(c);
% Chop out some of the smaller coefficients (less than umax)
% umax = 32;
umax = 8; 
Capprox = C;
for u=1:128
    if u > umax & u < 128-umax
        Capprox(u) = 0;
    end
end

% Take inverse fft
cApprox = ifft(Capprox);

% Show original boundary and approximated boundary
imshow(imcomplement(bwperim(I)));
hold on, plot(cApprox,'r');
