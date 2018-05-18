clear;

%read the first image and put it in a big background
im1=im2double(imread('goose/goose.2.pgm'));

% these numbers(-1500 -900 4000 2400) found with try and error no magic :)
m_matrixes_0 = [1   0  -1500;
     0   1  -900 ;
     0   0    1  ];
  
panaroma_size=[4000,2400];

% this is the accumulated transport function, it means that it is reletive
% to next transport when multiple by it
m_multiplied=m_matrixes_0;

% as we place the 3rd image in the background first after we add 1 and 2 we
% must comeback to original place and start for 4th image 
m_multiplied_start_point=m_multiplied;

% placing the first image in the background
final_panaroma=warp(im1',m_multiplied,panaroma_size);

% save the image for seeing the step by step output
imwrite(final_panaroma',['goose_panaroma_' num2str(0) '.png']);

% to keep track of number of output image and  number of transform in the
% object
panaroma_iteration=1;
im1=im2double(imread('goose/goose.2.pgm'));
im2=im2double(imread('goose/goose.1.pgm'));
[ m_multiplied, final_panaroma] = panaroma(im1,im2,m_multiplied,final_panaroma,panaroma_size);
% save the panaroma in a file
imwrite(final_panaroma',['goose_panaroma_' num2str(panaroma_iteration) '.png']);

panaroma_iteration=2;
im1=im2double(imread('goose/goose.1.pgm'));
im2=im2double(imread('goose/goose.0.pgm'));
[ ~, final_panaroma] = panaroma(im1,im2,m_multiplied,final_panaroma,panaroma_size);
% save the panaroma in a file
imwrite(final_panaroma',['goose_panaroma_' num2str(panaroma_iteration) '.png']);

m_multiplied=m_multiplied_start_point;
panaroma_iteration=3;
im1=im2double(imread('goose/goose.2.pgm'));
im2=im2double(imread('goose/goose.3.pgm'));
[ m_multiplied, final_panaroma] = panaroma(im1,im2,m_multiplied,final_panaroma,panaroma_size);
% save the panaroma in a file
imwrite(final_panaroma',['goose_panaroma_' num2str(panaroma_iteration) '.png']);

panaroma_iteration=4;
im1=im2double(imread('goose/goose.3.pgm'));
im2=im2double(imread('goose/goose.4.pgm'));
[ m_multiplied, final_panaroma] = panaroma(im1,im2,m_multiplied,final_panaroma,panaroma_size);
% save the panaroma in a file
imwrite(final_panaroma',['goose_panaroma_' num2str(panaroma_iteration) '.png']);

panaroma_iteration=5;
im1=im2double(imread('goose/goose.4.pgm'));
im2=im2double(imread('goose/goose.5.pgm'));
[ m_multiplied, final_panaroma] = panaroma(im1,im2,m_multiplied,final_panaroma,panaroma_size);
% save the panaroma in a file
imwrite(final_panaroma',['goose_panaroma_' num2str(panaroma_iteration) '.png']);

panaroma_iteration=6;
im1=im2double(imread('goose/goose.5.pgm'));
im2=im2double(imread('goose/goose.6.pgm'));
[ m_multiplied, final_panaroma] = panaroma(im1,im2,m_multiplied,final_panaroma,panaroma_size);
% save the panaroma in a file
imwrite(final_panaroma',['goose_panaroma_' num2str(panaroma_iteration) '.png']);


