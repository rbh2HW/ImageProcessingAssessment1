clear all
close all

%
% f = imread('C:\Users\rbhar\Documents\university\year 5\image processing\lab 5\github\ImageProcessingAssessment1\image1\legBone.tif');
f = imread('C:\Users\rbhar\Documents\university\year 5\image processing\lab 5\github\ImageProcessingAssessment1\image1\mapleLeaf.tif');
% f = imread('C:\Users\rbhar\Documents\university\year 5\image processing\lab 5\github\ImageProcessingAssessment1\image1\penny.tif');
% f = imread('C:\Users\rbhar\Documents\university\year 5\image processing\lab 5\github\ImageProcessingAssessment1\image1\square.tif');
% f = imread('C:\Users\rbhar\Documents\university\year 5\image processing\lab 5\github\ImageProcessingAssessment1\image1\triangle.tif');
figure, imshow(f);
% pause;
% %
f = im2double(f);
h = fspecial('gaussian',25,15);
g = imfilter(f,h,'replicate');
figure, imshow(g);

%
g = im2bw(g,1.7*graythresh(g));
figure, imshow(g);




%
% s = bwmorph(g,'skel',Inf);
% figure, imshow(s);
% pause;
% %
% s1 = bwmorph(s,'spur',25);
% figure, imshow(s1);

% f=g;
fSize=size(f);
% g = im2bw(f);

currentMatrix=zeros(3);

testMatrix=[{9,2,3},{8,1,4},{7,6,5}]
testMatrix=[9,2,3; 8,1,4; 7,6,5];

% workingArray=ones(fSize);

newF=zeros(fSize(1)+2,fSize(2)+2);
newF(2:fSize(1)+1,2:fSize(2)+1)=f;

%amount of times algo applied to image
for algoIterations=1:500
    disp(algoIterations)
    if algoIterations==1
        newIterationArray=newF;
        workingArray=ones(fSize);
        %     else
        %         newIterationArray(2:fSize(1)+1,2:fSize(2)+1)=newIterationArray(2:fSize(1)+1,2:fSize(2)+1).*double(workingArray);
        %         workingArray=ones(fSize);
    end


    %making program do certain if conditions so no repetition of code until
    % mulitplication ==0
    for task=1:2


        for x=2:(fSize(1))+1
            for y=2:(fSize(2))+1
                oneNeibourZero=newIterationArray(x-1,y-1)*newIterationArray(x-1,y)*newIterationArray(x-1,y+1)*newIterationArray(x+1,y-1)*newIterationArray(x+1,y)*newIterationArray(x+1,y+1)*newIterationArray(x,y+1)*newIterationArray(x,y-1);
                if newIterationArray(x,y)==1 && oneNeibourZero==0
                    nonZeroTotal=0;
                    if newIterationArray(x-1,y-1)%left top
                        nonZeroTotal=nonZeroTotal+1;
                    end

                    if newIterationArray(x-1,y)%left middle
                        nonZeroTotal=nonZeroTotal+1;
                    end
                    if newIterationArray(x-1,y+1) % left bottom
                        nonZeroTotal=nonZeroTotal+1;
                    end
                    if newIterationArray(x+1,y-1) % right top
                        nonZeroTotal=nonZeroTotal+1;
                    end
                    if newIterationArray(x+1,y) % right middle
                        nonZeroTotal=nonZeroTotal+1;
                    end
                    if newIterationArray(x+1,y+1) % right bottom
                        nonZeroTotal=nonZeroTotal+1;
                    end
                    if newIterationArray(x,y+1) % bottom middle
                        nonZeroTotal=nonZeroTotal+1;
                    end
                    if newIterationArray(x,y-1) % top middle
                        nonZeroTotal=nonZeroTotal+1;
                    end
                    %%
                    %condition a
                    if (nonZeroTotal>=2) && (nonZeroTotal<=6)

                        sequence=[newIterationArray(x-1,y) newIterationArray(x-1,y+1) newIterationArray(x,y+1) newIterationArray(x+1,y+1) newIterationArray(x+1,y) newIterationArray(x+1,y-1) newIterationArray(x-1,y) newIterationArray(x-1,y-1) newIterationArray(x-1,y)];
                        %           p2,                          p3,                             p4,                  p5,                    p6,                     p7,                          p8,                    p9,                         p2

                        TValue=0;
                        for k=1:numel(sequence)-1

                            if(sequence(k)==0 && sequence(k+1)==1)
                                TValue=TValue+1;
                            end

                        end

                        %%
                        %condition b - only done if a and b
                        if TValue==1


                            if task==1
                                %condition c
                                conditionc=newIterationArray(x-1,y) *newIterationArray(x,y+1)*newIterationArray(x+1,y);
                                if conditionc==0

                                    %condition d task 1
                                    conditiond=newIterationArray(x,y+1) *newIterationArray(x+1,y) *newIterationArray(x,y-1);
                                    if conditiond==0
                                        %                                                                 disp("set zero")
                                        workingArray(x-1,y-1)=0;
                                    end

                                end
                            else
                                %condition task 2
                                conditionc=newIterationArray(x-1,y) *newIterationArray(x,y+1)*newIterationArray(x,y-1);
                                if conditionc==0

                                    %condition d task 2
                                    conditiond=newIterationArray(x-1,y) *newIterationArray(x+1,y) *newIterationArray(x,y-1);
                                    if conditiond==0
                                        %                                                                 disp("set zero")
                                        workingArray(x-1,y-1)=0;
                                    end

                                end
                            end


                        end


                    end

                end
            end

        end
        %deleting the values after the tasks
        newIterationArray(2:fSize(1)+1,2:fSize(2)+1)=newIterationArray(2:fSize(1)+1,2:fSize(2)+1).*double(workingArray);
        workingArray=ones(fSize);
    end



end

% newIterationArray(2:fSize(1)+1,2:fSize(2)+1)=newIterationArray(2:fSize(1)+1,2:fSize(2)+1).*double(workingArray);
finalImage=newIterationArray(2:fSize(1)+1,2:fSize(2)+1);
subplot(1,2,1)
imshow(f)
subplot(1,2,2)
imshow(finalImage)