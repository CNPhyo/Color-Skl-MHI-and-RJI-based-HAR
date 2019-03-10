% Create skeleton connection map to link the joints.
clear;
clc;
SkeletonConnectionMap=[
                        [1,2];
                        [2,3];
                        [2,4];
                        [2,6];
                        [4,5];
                        [6,7];
                        [5,12];
                        [7,13];
                        [9,14];
                        [8,9];
                        [10,11];                        
                        [3,8];
                        [3,10];
                        [11,15]
                        ];
width = 320;
height= 240;
N=15;
NJoint = 14;
ColorSet=[0,1,0;0,1,0.333333333333333;0,1,0.666666666666667;0,1,1;0,0.666666666666667,1;0,0.333333333333333,1;0,0,1;0.333333333333333,0,1;0.666666666666667,0,1;1,0,1;1,0,0.666666666666667;1,0,0.333333333333333;1,0,0;0.666666666666667,0,0;0.333333333333333,0,0];
All_ElpasedTime_CSklMHI = zeros(10,1);
start_frame = N;
RJ1_Data   = zeros(10,3*NJoint*N);
RJ2_Data   = zeros(10,3*NJoint*N);
RJ3_Data   = zeros(10,3*NJoint*N);
RJ4_Data   = zeros(10,3*NJoint*N);
ColorSklMHI= zeros(10,62*62*3);
all_labels = zeros(10,1);
all_S = zeros(10,1);
all_File = zeros(10,1);
delimiters={'_'};
total_c=0;

for pid=1:4
    
folder = ['datasets\CAD60\data' num2str(pid) '\'];
allFiles = dir(fullfile(folder,'*.txt'));

for fil= 1:length(allFiles)
fileName = allFiles(fil).name;
myFile = split(fileName,delimiters{1});
act_id    = str2double(myFile{1});
[ all_joints ] = Fun_ExtractJointPoint(folder,fileName );
All_SklData = cell(1,1);
c =0;
RJ1Dif= zeros(42,round(size(all_joints,1)/2));
RJ2Dif= zeros(42,round(size(all_joints,1)/2));
RJ3Dif= zeros(42,round(size(all_joints,1)/2));
RJ4Dif= zeros(42,round(size(all_joints,1)/2));

for frame=1:2:size(all_joints,1)
    c = c+1;
    All_SklData(c,1) = { all_joints(frame,:) }; 
    [RJ1,RJ2,RJ3,RJ4] = Fun_ExtractRJI1_4(all_joints(frame,:));
    RJ1Dif(:,c) = RJ1;
    RJ2Dif(:,c) = RJ2;
    RJ3Dif(:,c) = RJ3;
    RJ4Dif(:,c) = RJ4;
end

totalLines=length(All_SklData);
count = 0;
start_frame= N;
for frame=start_frame:1:totalLines
MH_img  = zeros(height,width,3);
color_c = 1;
tic
for k = frame-(N-1):frame
    all_data  = All_SklData{k,1};  
    color_img = Fun_Create_SklImg(all_data(1,2:46),ColorSet, color_c,SkeletonConnectionMap);
    MH_img = MH_img + color_img;
    color_c= color_c+1;
end
MH_img_r =MH_img(:,:,1);
MH_img_g =MH_img(:,:,2);
MH_img_b =MH_img(:,:,3);
bw_img=zeros(height,width);
bw_img(MH_img_r>0)=1;
bw_img(MH_img_g>0)=1;
bw_img(MH_img_b>0)=1;
bw_img = bwareaopen(bw_img,200);
stats= regionprops(bw_img);
for i=1:1
    bb = stats(i).BoundingBox;
    if bb(1,3) < bb(1,4)
     bb1=[bb(1,1)-40 bb(1,2)-20,bb(1,3)+80, bb(1,4)+20];
    else
     bb1=[bb(1,1)-20 bb(1,2)-20,bb(1,3)+40, bb(1,4)+20];
    end
    bb1(bb1<0)=1;
    if(bb(1,3) > width)
        bb(1,3)= width;
    end
    if(bb(1,4) > height)
        bb(1,4)= height;
    end
    crp_img = imcrop(MH_img,bb1);
    r_img = imresize(crp_img, [62, 62]);
    D1_img = reshape( r_img,[1,62*62*3]);
end
total_c = total_c+1;
ColorSklMHI(total_c,:)= im2double(D1_img);
data1 = reshape(RJ1Dif(:,frame -(N-1) : frame)',[1,3*NJoint*N]);
RJ1_Data (total_c,:) = data1;
data2 = reshape(RJ2Dif(:,frame -(N-1) : frame)',[1,3*NJoint*N]);
RJ2_Data (total_c,:) = data2;
data3 = reshape(RJ3Dif(:,frame -(N-1) : frame)',[1,3*NJoint*N]);
RJ3_Data (total_c,:) = data3;
data4 = reshape(RJ4Dif(:,frame -(N-1) : frame)',[1,3*NJoint*N]);
RJ4_Data (total_c,:) = data4;
all_labels(total_c,1) = act_id;
all_S(total_c,1) = pid;
all_File(total_c,1)=fil;
end
end
end

save CAD60_ColorSklMHI_RJI_Data_T_15.mat ColorSklMHI RJ1_Data RJ2_Data RJ3_Data RJ4_Data all_labels all_S  all_File -v7.3;



