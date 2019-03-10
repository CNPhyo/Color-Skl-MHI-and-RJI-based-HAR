clc;
addpath('C:/caffe/matlab');
% caffe.set_mode_cpu();
caffe.set_mode_gpu();
gpu_id = 0; 
caffe.set_device(gpu_id);
net_weights1 = ['../../models/UTKinect/UTKinect_RJI_1_NotP10.caffemodel'];
net_weights2 = ['../../models/UTKinect/UTKinect_RJI_2_NotP10.caffemodel'];
net_weights3 = ['../../models/UTKinect/UTKinect_RJI_3_NotP10.caffemodel'];
net_weights4 = ['../../models/UTKinect/UTKinect_RJI_4_NotP10.caffemodel'];
net_weights5 = ['../../models/UTKinect/UTKinect_ColorSklMHI_NotP10.caffemodel'];

net_model = ['utkinect_RJI_deploy.prototxt'];
net_model2 = ['utkinect_ColorSklMHI_deploy.prototxt'];
net1 = caffe.Net(net_model, net_weights1, 'test');
net2 = caffe.Net(net_model, net_weights2, 'test');
net3 = caffe.Net(net_model, net_weights3, 'test');
net4 = caffe.Net(net_model, net_weights4, 'test');
net5 = caffe.Net(net_model2, net_weights5, 'test');

load ('UTKinect_Clip_SklMHI_T_15.mat');

pid = 10;

RJ1_Data_Test = RJ1_Data(all_S==pid,:);
RJ2_Data_Test = RJ2_Data(all_S==pid,:);
RJ3_Data_Test = RJ3_Data(all_S==pid,:);
RJ4_Data_Test = RJ4_Data(all_S==pid,:);
colorSklMHI_Test = ColorSklMHI(all_S==pid,:);
test_lbl = all_labels(all_S==pid);
test_e = all_E(all_S==pid);
total = size(test_lbl,1);
N = 15;
N_J = 19;
N_J2 = 62;
N2   = 62;
test_img1 = double(reshape(RJ1_Data_Test',[N,N_J,3,total]));
test_img2 = double(reshape(RJ2_Data_Test',[N,N_J,3,total]));
test_img3 = double(reshape(RJ3_Data_Test',[N,N_J,3,total]));
test_img4 = double(reshape(RJ4_Data_Test',[N,N_J,3,total]));
test_img5 = double(reshape(colorSklMHI_Test',[N2,N_J2,3,total]));
test_data = {test_img1,test_img2,test_img3,test_img4,test_img5};
net_data = {net1,net2,net3,net4,net5};

[result_lbl,result_val] = Fun_TestDCNN_Features(test_data,test_lbl,net_data);

final_acc = 0;
for eId=1:2
correct =0;
sum_prob_RJI = zeros(total_act,total_act);
for act = 0 : total_act-1
temp_result = result_lbl(test_lbl==act & test_e==eId);
if(length(unique(temp_result))>1)
uni_results = unique(temp_result);
[class_count,class_id] = hist(temp_result,uni_results);
[max_val,~]   = max(class_count);
max_c1 = find(class_count == max_val,1,'last');
if(size(class_id,1) >= size(class_id,2))
final_class = class_id(max_c1,1);
else
final_class = class_id(1,max_c1);    
end
else
final_class = unique(temp_result);
end
if (act==final_class)
   correct = correct+1;
end
end
acc1  = (correct / (total_act ) ) *100;
final_acc = final_acc + acc1;
end
fprintf('Final Video Accuracy = %d \n',(final_acc)/2);
caffe.reset_all();



