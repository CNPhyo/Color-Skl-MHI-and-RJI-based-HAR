clear;
close all;
clc;
addpath('..\..\tools\Kin2');
k2 = Kin2('color','depth','infrared');
SkeletonConnectionMap = [[1 2]; % Spine
                         [2 3];
                         [3 4];
                         [3 5]; %Left Hand
                         [5 6];
                         [6 7];
                         [7 8];
                         [3 9]; %Right Hand
                         [9 10];
                         [10 11];
                         [11 12];
                         [1 17]; % Right Leg
                         [17 18];
                         [18 19];
                         [19 20];
                         [1 13]; % Left Leg
                         [13 14];
                         [14 15];
                         [15 16]];                     
count = 0;
N = 15;
NJoint = 19;
RJ1_Data   = zeros(10,3*NJoint*N);
RJ2_Data   = zeros(10,3*NJoint*N);
RJ3_Data   = zeros(10,3*NJoint*N);
RJ4_Data   = zeros(10,3*NJoint*N);
ColorSklMHI= zeros(10,62*62*3);
all_labels = zeros(10,1);
all_S = zeros(10,1);
all_E = zeros(10,1);
total_c = 0;
act_count=0;
delimiteYs={'a','s','e',','};
act_arr= {'carry','clapHands','pickUp','pull','push','sitDown','standUp','throw','walk','waveHands'};
total_count = 0;
train_feature=zeros(100,28);
train_lbl = zeros(100,1);
total_file =0;
LblFld = '..\..\datasets\UTKinect\actions\';
JointsFld   = '..\..\datasets\UTKinect\joints\';
width = 480;
height= 270;
ColorSet=[0,1,0;0,1,0.333333333333333;0,1,0.666666666666667;0,1,1;0,0.666666666666667,1;0,0.333333333333333,1;0,0,1;0.333333333333333,0,1;0.666666666666667,0,1;1,0,1;1,0,0.666666666666667;1,0,0.333333333333333;1,0,0;0.666666666666667,0,0;0.333333333333333,0,0];
for p_id=1:10
    if(p_id<10)
        s=sprintf('0%d',p_id);
    else
        s= num2str(10);
    end
for e_id=1:2
fprintf('\n pid = %d, eid = %d\n',p_id,e_id);
if(e_id<10)
   aID=sprintf('0%d',e_id);
else
   aID= num2str(10);
end
all_actions = zeros(1,3);
file1 = ['s' s '_e' aID];
total_file=total_file+1;
count   = 0;
All_SklData = cell(1,1);
allFNames=zeros(1,10);

file2 = ['joints_s' s '_e' aID ];
JointFile = [JointsFld file2  '.txt'];
fid2 = fopen(JointFile);
line_ex = fgetl(fid2);
prev_actID=0;

while (line_ex~=-1)
C = textscan(line_ex,'%f');
count =count+1;
data=cell2mat(C);
frame= data(1,1);
allFNames(1,count) = frame; 
skl = data(2:end,1);
skl1= reshape(skl,[3,20]);
skl2= skl1';
JointIndices= reshape(skl2,[20,3]);
ptColor = k2.mapCameraPoints2Color(JointIndices);
Coordinate = abs(double(ptColor));
colorJointIndices_N=Coordinate /4 ;
All_SklData(count,1)={colorJointIndices_N};
[RJ1,RJ2,RJ3,RJ4] = Fun_ExtractRJI1_4(JointIndices);
RJ1Dif(:,count) = RJ1;
RJ2Dif(:,count) = RJ2;
RJ3Dif(:,count) = RJ3;
RJ4Dif(:,count) = RJ4;  
line_ex = fgetl(fid2);
end
fclose(fid2);

Sort_allFName = sort(allFNames);
ActFile = [LblFld file1 '.txt'];
if exist(ActFile, 'file') == 2
disp('File exist!');
fid1  = fopen(ActFile);
count = 0;
line_ex = fgetl(fid1);

while (line_ex~=-1)
C = textscan(line_ex,'%s');
count   = count+1;
lbldata      = C{1,1};
actstr=  lbldata{1,1};
action  =  strrep(actstr,':','');
IndexC  =  strfind(act_arr, action);
act_id  =  find(not(cellfun('isempty', IndexC)));
start_f  = str2double(lbldata{2,1});
end_f = str2double(lbldata{3,1});
[~,newStartF]=find(Sort_allFName==start_f);
[~,newEndF]=find(Sort_allFName==end_f);
all_actions(count,1) = act_id;
all_actions(count,2) = newStartF;
all_actions(count,3) = newEndF;
line_ex = fgetl(fid1);
end
fclose(fid1);
end
% end extraction action labels

for j=1:size(all_actions,1)
act_id = all_actions(j,1);
newStart= all_actions(j,2);
newEndF = all_actions(j,3);
StartF = newStart;
EndF = newEndF;
total_f = (EndF - StartF)+1;
fprintf('act_id= %d \n',act_id-1);
fprintf('total_f= %d \n',total_f);
fprintf('StartF= %d, EndF= %d \n',StartF,EndF); 
if (total_f < N)
Req_f = N - total_f;
   if mod(Req_f,2) ==0
       StartF = newStart - floor(Req_f/2);
       EndF = newEndF   + floor(Req_f/2);
   else
       StartF = newStart - floor(Req_f/2);
       EndF = newEndF   + floor(Req_f/2)+1;
   end
   fprintf('New StartF= %d, New  EndF= %d \n',StartF,EndF); 
end

for fr= StartF+(N-1) : EndF
   total_c = total_c +1;   
   MH_img=zeros(height,width,3);
   color_c=1;
for k = fr-(N-1):fr
   color_img = Fun_Create_SklImg(All_SklData{k,1},ColorSet,color_c,SkeletonConnectionMap);
   MH_img = MH_img + color_img;
   color_c= color_c + 1;
end
MH_img_r = MH_img(:,:,1);
MH_img_g = MH_img(:,:,2);
MH_img_b = MH_img(:,:,3);
bw_img=zeros(height,width);
bw_img(MH_img_r>0)= 1;
bw_img(MH_img_g>0)= 1;
bw_img(MH_img_b>0)= 1;
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
    ColorSklMHI(total_c,:)=im2double(D1_img);
    data1 = reshape(RJ1Dif(:,fr-(N-1) : fr)',[1,3*NJoint*N]);
    RJ1_Data (total_c,:) = data1;
    data2 = reshape(RJ2Dif(:,fr-(N-1) : fr)',[1,3*NJoint*N]);
    RJ2_Data (total_c,:) = data2;
    data3 = reshape(RJ3Dif(:,fr-(N-1) : fr)',[1,3*NJoint*N]);
    RJ3_Data (total_c,:) = data3;
    data4 = reshape(RJ4Dif(:,fr-(N-1) : fr)',[1,3*NJoint*N]);
    RJ4_Data (total_c,:)  = data4;    
    all_labels(total_c,1) = act_id-1;
    all_S(total_c,1) = p_id;
    all_E(total_c,1) = e_id; 
end
end
end
end

save UTKinect_ColorSklMHI_RJI_Data_T_15.mat ColorSklMHI RJ1_Data RJ2_Data RJ3_Data RJ4_Data all_labels all_S all_E -v7.3;

