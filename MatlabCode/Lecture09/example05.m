%%
%Refine a Gray Scale Image
%%


clear
clc
load clown
figure
V = single(X(1:124,75:225));
imagesc(V);
colormap gray
axis image
axis off
title('Original Image');
% Improve quality
Vq = interp2(V,5);
figure
imagesc(Vq);
colormap gray
axis image
axis off
title('Linear Interpolation');