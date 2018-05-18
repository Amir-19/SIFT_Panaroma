function [A,b] = find_A_B_least_squares(image1_matches, image2_matches)

    %initilize matrix A
    A=zeros(2*ceil(size(image1_matches,1)/2),8);
    i=1:2:size(A,1);
    
    % place image 1 and image 2 matches in the matrix A
    A(i,1:3)=[image1_matches((i+1)/2,:) ones(size(A,1)/2,1)];
    A(i,7:8)=-image1_matches((i+1)/2,:).*repmat(image2_matches((i+1)/2,1),1,2);
    A(i+1,4:6)=[image1_matches((i+1)/2,:) ones(size(A,1)/2,1)];
    A(i+1,7:8)=-image1_matches((i+1)/2,:).*repmat(image2_matches((i+1)/2,2),1,2);
    
    % transpose to get matrix b 
    transpose=image2_matches(1:size(A,1)/2,:)';
    b=transpose(:);
end