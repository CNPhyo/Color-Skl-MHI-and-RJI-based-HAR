function [img_skl] = Fun_Create_SklImg(all_data,ColorSet, color_c,SkeletonConnectionMap)
% all_jp= all_data (1,2:46);
all_jp= all_data;
all_jp = reshape (all_jp, [15,3]);
% all_XY = zeros(15,2);
x = 156.8584456124928 + 0.0976862095248 * all_jp(:,1) - 0.0006444357104 * all_jp(:,2) + 0.0015715946682 * all_jp(:,3);
y = 125.5357201011431 + 0.0002153447766 * all_jp(:,1) - 0.1184874093530 * all_jp(:,2) - 0.0022134485957 * all_jp(:,3);
all_XY=[x,y];
img_skl = zeros(240,320,3);
x11=[all_XY(SkeletonConnectionMap(:,1),1,1) all_XY(SkeletonConnectionMap(:,1),2,1)];
y11=[all_XY(SkeletonConnectionMap(:,2),1,1) all_XY(SkeletonConnectionMap(:,2),2,1)];
img_skl = insertShape(img_skl,'Line',int32([x11,y11]),'Color', ColorSet(color_c,:),'LineWidth',3);
end
