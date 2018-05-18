%panaroma.m add im2 to the panaroma with respect to its transformation to
%match im1 in an image background with size panaroma_size
%
%input:
%   im1: image 1 
%   im2: image 2
%   m_multiplied: the accumulated tranformation till now
%   panaroma: the current panaroma we made
%   panaroma_size: size of the background with place in
%
%output:
%   m_multiplied: the accumulated tranformation till now multiplied by
%   current tranformation
%   panaroma: the new panaroma after this run

function [ m_multiplied, panaroma] = panaroma(im1, im2,m_multiplied,panaroma,panaroma_size)
    
    % need to keep that to add to panaroma
    im2_transpse=im2';
    % here we get the sift feature's of the image with VLFEAT
    [~,f1,f2,ok,matches] = sift_mosaic(im1, im2);
    
    % get matched points of the image 1
    x1=f1(1,matches(1,ok));
    y1=f1(2,matches(1,ok));
    
    % get matched points of the image 2
    x2=f2(1,matches(2,ok));
    y2=f2(2,matches(2,ok));

    % make twp vectors with matched image 1 and image 2
    image1_matches = zeros(size(x1,2),2);
    image2_matches = zeros(size(x1,2),2);

    for i = 1:size(x1,2)

        image1_matches(i,:)=[y1(1,i),x1(1,i)];
        image2_matches(i,:)=[y2(1,i),x2(1,i)];
    end

    % to make compuatation faster lets only use the first ones 
    if(size(image1_matches,1)>100)
        
        image1_matches=image1_matches(1:100,:);
        image2_matches=image2_matches(1:100,:);
    end
    
    % find A and b to get solve Ax=b 
    [A,b]=find_A_B_least_squares(image1_matches,image2_matches);
 
    % x calculation with lease squares
    x=inv(A'*A)*A'*b;
    

    % find transformation of images
    Mtemp = [x(1) x(2) x(3);
             x(4) x(5) x(6);
             x(7) x(8)  1 ];
    
    % get transform image acculmulated by
    m_multiplied=Mtemp*m_multiplied;
    
    % find the tranformation of image 2 in blank panaroma
    panaroma_im2=warp(im2_transpse,m_multiplied,panaroma_size);
    
    %find the mask of image 2 in tranformed image
    mask=warp(ones(size(im2_transpse)),m_multiplied,panaroma_size);
    
    % add only the part of image 2 panaroma which is needed
    panaroma(mask==1)=panaroma_im2(mask==1);
end