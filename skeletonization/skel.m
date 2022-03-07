clear all
close all

%
f = imread('electron_micrograph_of_a_human_chromosome.jpg');
figure, imshow(f);
pause;
%
f = 1-im2double(f);
h = fspecial('gaussian',25,15);
g = imfilter(f,h,'replicate');
figure, imshow(g);
pause;
%
g = im2bw(g,1.7*graythresh(g));
figure, imshow(g);
pause;
%
s = bwmorph(g,'skel',Inf);
figure, imshow(s);
pause;
%
s1 = bwmorph(s,'spur',25);
figure, imshow(s1);


fSize=size(f);
fCopy=f;
currentMatrix=zeros(3);

for i=1:fSize(1)
    for j=1:fSize(2)


        nonZeroTotal=0;
        if ~fCopy(i-1,j-1)%left top
            nonZeroTotal=nonZeroTotal+1;
        end

        if ~fCopy(i-1,j)%left middle
            nonZeroTotal=nonZeroTotal+1;
        end
        if ~fCopy(i-1,j+1) % left bottom
            nonZeroTotal=nonZeroTotal+1;
        end
        if ~fCopy(i+1,j-1) % right top
            nonZeroTotal=nonZeroTotal+1;
        end
        if ~fCopy(i,j) % right middle
            nonZeroTotal=nonZeroTotal+1;
        end
        if ~fCopy(i+1,j+1) % right bottom
            nonZeroTotal=nonZeroTotal+1;
        end
        if ~fCopy(i,j+1) % bottom middle
            nonZeroTotal=nonZeroTotal+1;
        end
        if ~fCopy(i,j-1) % top middle
            nonZeroTotal=nonZeroTotal+1;
        end

        %condition a
        if (nonZeroTotal>=2) && (nonZeroTotal<=6)
           

            %condition b
                if
            %condition c

            %condition d

        end

    end
end
