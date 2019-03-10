load CAD60_ColorSklMHI_RJI_Data_T_15.mat  ColorSklMHI all_S all_labels all_File
p_id=1;
all_labels_P1 = all_labels(all_S==p_id);
RJ1_Data_P1 = RJ1_Data(all_S==p_id,:);
RJ2_Data_P1 = RJ2_Data(all_S==p_id,:);
RJ3_Data_P1 = RJ3_Data(all_S==p_id,:);
RJ4_Data_P1 = RJ4_Data(all_S==p_id,:);
ColorSklMHI_P1 = ColorSklMHI(all_S==p_id,:);

all_labels_NotP1 = all_labels(all_S~=p_id);
RJ1_Data_NotP1 = RJ1_Data(all_S~=p_id,:);
RJ2_Data_NotP1 = RJ2_Data(all_S~=p_id,:);
RJ3_Data_NotP1 = RJ3_Data(all_S~=p_id,:);
RJ4_Data_NotP1 = RJ4_Data(all_S~=p_id,:);
ColorSklMHI_NotP1 = ColorSklMHI(all_S~=p_id,:);

p_id=2;
all_labels_P2 = all_labels (all_S==p_id);
RJ1_Data_P2 = RJ1_Data(all_S==p_id,:);
RJ2_Data_P2 = RJ2_Data(all_S==p_id,:);
RJ3_Data_P2 = RJ3_Data(all_S==p_id,:);
RJ4_Data_P2 = RJ4_Data(all_S==p_id,:);
ColorSklMHI_P2 = ColorSklMHI(all_S==p_id,:);

all_labels_NotP2 = all_labels (all_S~=p_id);
RJ1_Data_NotP2 = RJ1_Data(all_S~=p_id,:);
RJ2_Data_NotP2 = RJ2_Data(all_S~=p_id,:);
RJ3_Data_NotP2 = RJ3_Data(all_S~=p_id,:);
RJ4_Data_NotP2 = RJ4_Data(all_S~=p_id,:);
ColorSklMHI_NotP2 = ColorSklMHI(all_S~=p_id,:);

p_id=3;
all_labels_P3 = all_labels (all_S==p_id);
RJ1_Data_P3 = RJ1_Data(all_S==p_id,:);
RJ2_Data_P3 = RJ2_Data(all_S==p_id,:);
RJ3_Data_P3 = RJ3_Data(all_S==p_id,:);
RJ4_Data_P3 = RJ4_Data(all_S==p_id,:);
ColorSklMHI_P3 = ColorSklMHI(all_S==p_id,:);

all_labels_NotP3 = all_labels (all_S~=p_id);
RJ1_Data_NotP3 = RJ1_Data(all_S~=p_id,:);
RJ2_Data_NotP3 = RJ2_Data(all_S~=p_id,:);
RJ3_Data_NotP3 = RJ3_Data(all_S~=p_id,:);
RJ4_Data_NotP3 = RJ4_Data(all_S~=p_id,:);
ColorSklMHI_NotP3 = ColorSklMHI(all_S~=p_id,:);

p_id=4;
all_labels_P4 = all_labels (all_S==p_id);
RJ1_Data_P4 = RJ1_Data (all_S==p_id,:);
RJ2_Data_P4 = RJ2_Data (all_S==p_id,:);
RJ3_Data_P4 = RJ3_Data (all_S==p_id,:);
RJ4_Data_P4 = RJ4_Data (all_S==p_id,:);
ColorSklMHI_P4 = ColorSklMHI(all_S==p_id,:);

all_labels_NotP4 = all_labels (all_S~=p_id);
RJ1_Data_NotP4 = RJ1_Data (all_S~=p_id,:);
RJ2_Data_NotP4 = RJ2_Data (all_S~=p_id,:);
RJ3_Data_NotP4 = RJ3_Data (all_S~=p_id,:);
RJ4_Data_NotP4 = RJ4_Data (all_S~=p_id,:);
ColorSklMHI_NotP4 = ColorSklMHI(all_S~=p_id,:);

save CAD60_LOSOCV_ColorSklMHI_RJI_Data.mat -v7.3;

