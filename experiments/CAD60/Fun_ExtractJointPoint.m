function [ all_joints ] = Fun_ExtractJointPoint( folder,fileName )

Input_Fld = [folder fileName ];
    fid = fopen(Input_Fld);
    tline = num2str(fgetl(fid));
    all_joints = zeros(10,46);
    all_count =0;
    while ~strcmp(tline,'END')
        all_count = all_count+1;
        newStr = strrep(tline,',',' ');
        all_data = cell2mat(textscan(newStr,'%f'));
        fnum = all_data (1,1);
            joint_pos = zeros(15,3);
            count =0;
            for i=2:14:155
                x= (i+10);
                y= (i+11);
                z= (i+12);
                count =count+1;
            joint_pos(count,:)=all_data([x,y,z],1);
            end
            for i=156:4:171
                x= i;
                y= i+1;
                z= i+2;
                count =count+1;
            joint_pos(count,:)=all_data([x,y,z],1);
            end
        all_joints(all_count,:)= [fnum,reshape(joint_pos,[1,45])];    
        tline = fgetl(fid);
    end
end