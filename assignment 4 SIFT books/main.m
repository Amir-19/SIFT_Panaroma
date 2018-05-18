clear;

%read the first image and put it in a big background
im1=im2double(imread('books/books0.pgm'));

% these numbers(-1500 -900 4000 2400) found with try and error no magic :)
m_matrixes_0 = [1   0  -30;
     0   1  -30 ;
     0   0    1  ];
  
panaroma_size=[375,300];

% this is the accumulated transport function, it means that it is reletive
% to next transport when multiple by it
m_multiplied=m_matrixes_0;

% as we place the 3rd image in the background first after we add 1 and 2 we
% must comeback to original place and start for 4th image 
m_multiplied_start_point=m_multiplied;

% placing the first image in the background
final_panaroma=warp(im1',m_multiplied,panaroma_size);

% save the image for seeing the step by step output
imwrite(final_panaroma',['books_panaroma' num2str(0) '.png']);

% to keep track of number of output image and  number of transform in the
% object
panaroma_iteration=1;
im1=im2double(imread('books/books0.pgm'));
im2=im2double(imread('books/books1.pgm'));
[ m_multiplied, final_panaroma] = panaroma(im1,im2,m_multiplied,final_panaroma,panaroma_size);
% save the panaroma in a file
imwrite(final_panaroma',['books_panaroma' num2str(panaroma_iteration) '.png']);
