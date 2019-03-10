clc;
addpath('C:/caffe/matlab');
caffe.set_mode_gpu();
gpu_id = 0; 
caffe.set_device(gpu_id);
net_weights1 = ['../../models/CAD60/CAD60_RJI_1_NotP1.caffemodel'];
net_weights2 = ['../../models/CAD60/CAD60_RJI_2_NotP1.caffemodel'];
net_weights3 = ['../../models/CAD60/CAD60_RJI_3_NotP1.caffemodel'];
net_weights4 = ['../../models/CAD60/CAD60_RJI_4_NotP1.caffemodel'];
net_weights5 = ['../../models/CAD60/CAD60_ColorSklMHI_NotP1.caffemodel'];

% load('CAD60_ColorSklMHI_RJI_Data_T_15.mat');

net_model = ['cad60_RJI_deploy.prototxt'];
net_model2 = ['cad60_ColorSklMHI_deploy.prototxt'];
net1 = caffe.Net(net_model, net_weights1, 'test');
net2 = caffe.Net(net_model, net_weights2, 'test');
net3 = caffe.Net(net_model, net_weights3, 'test');
net4 = caffe.Net(net_model, net_weights4, 'test');
net5 = caffe.Net(net_model2, net_weights5, 'test');

pid = 1;

RJ1_Data_Test = RJ1_Data(all_S==pid,:);
RJ2_Data_Test = RJ2_Data(all_S==pid,:);
RJ3_Data_Test = RJ3_Data(all_S==pid,:);
RJ4_Data_Test = RJ4_Data(all_S==pid,:);
colorSklMHI_Test = ColorSklMHI(all_S==pid,:);
test_lbl = all_labels(all_S==pid);
N = 15;
N_J = 14;
N2 = 62;
N_J2 = 62;
total = size(test_lbl,1);
test_img1 = double(reshape(RJ1_Data_Test',[N,N_J,3,total]));
test_img2 = double(reshape(RJ2_Data_Test',[N,N_J,3,total]));
test_img3 = double(reshape(RJ3_Data_Test',[N,N_J,3,total]));
test_img4 = double(reshape(RJ4_Data_Test',[N,N_J,3,total]));
test_img5 = double(reshape(colorSklMHI_Test',[N2,N_J2,3,total]));
test_data = {test_img1,test_img2,test_img3,test_img4,test_img5};
net_data = {net1,net2,net3,net4,net5};
[result_lbl,result_val] = Fun_TestDCNN_Features(test_data,test_lbl,net_data);
correct = 0;
total_act=13;
final_class=0;
for act = 0 : total_act-1
temp_result = result_lbl(test_lbl==act);
if(length(unique(temp_result))>1)
uni_results = unique(temp_result);
[class_count,class_id] = hist(temp_result,uni_results);
[max_val,max_c]   = max(class_count);
[all_max_val,all_max_id]= find(class_count == max_val);
if(length(all_max_id)>1)
    all_maxResultId = class_id(all_max_id);
    allSumProb = zeros(length(all_max_id),1);
    for jj=1:length(all_max_id)
        allSumProb(jj,1)=sum(temp_val(temp_result==all_maxResultId(jj)));
    end
    [max_prob,max_c1]    = max(allSumProb);
    final_class = all_maxResultId(max_c1);
else    
    final_class = class_id(all_max_id,1);
end
else
final_class = unique(temp_result);
end
if (act==final_class)
   correct = correct+1; 
end
end
final_acc  = (correct / (total_act ) ) *100;
fprintf('Final Video Accuracy = %f \n',final_acc);

caffe.reset_all();



