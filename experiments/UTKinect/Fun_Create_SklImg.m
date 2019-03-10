function[img_skl]= Fun_Create_Skl(colorJointIndices_N,ColorSet, color_c,SkeletonConnectionMap)
x11=int32([colorJointIndices_N(SkeletonConnectionMap(:,1),1,1) colorJointIndices_N(SkeletonConnectionMap(:,1),2,1)]);
y11=int32([colorJointIndices_N(SkeletonConnectionMap(:,2),1,1) colorJointIndices_N(SkeletonConnectionMap(:,2),2,1)]);
img_skl = zeros(270,480,3);
x12=x11(x11~=0 & y11~=0);
x13 = reshape( x12,[length(x12)/2,2]);
y12 = y11(x11~=0 & y11~=0);
y13 = reshape( y12,[length(y12)/2,2]);
img_skl = insertShape(img_skl,'Line',[x13,y13],'Color', ColorSet(color_c,:),'LineWidth',3);
end

