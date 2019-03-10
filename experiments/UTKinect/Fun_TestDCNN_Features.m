function[result_lbl,result_val]= Fun_TestDCNN_Features(test_data,test_lbl,net_data)
N = 15;
N_J = 19;
N_J2 = 62;
N2   = 62;
test_img1 = test_data{1,1};
test_img2 = test_data{1,2};
test_img3 = test_data{1,3};
test_img4 = test_data{1,4};
test_img5 = test_data{1,5};
net1 = net_data{1,1};
net2 = net_data{1,2};
net3 = net_data{1,3};
net4 = net_data{1,4};
net5 = net_data{1,5};
total = length(test_lbl);
result_lbl = zeros(total,1);
result_val = zeros(total,1);

for i=1:total
im_1 = test_img1(:,:,:,i);
im_2 = test_img2(:,:,:,i);
im_3 = test_img3(:,:,:,i);
im_4 = test_img4(:,:,:,i);
im_5 = test_img5(:,:,:,i);
input_data1 = {reshape(im_1,[N,N_J,3,1])};
input_data2 = {reshape(im_2,[N,N_J,3,1])};
input_data3 = {reshape(im_3,[N,N_J,3,1])};
input_data4 = {reshape(im_4,[N,N_J,3,1])};
input_data5 = {reshape(im_5,[N2,N_J2,3,1])};
scores = net1.forward(input_data1);
scores1 = scores{1};
scores = net2.forward(input_data2);
scores2 =  scores{1};
scores = net3.forward(input_data3);
scores3 =  scores{1};
scores = net4.forward(input_data4);
scores4 =  scores{1};
scores = net5.forward(input_data5);
scores5 =  scores{1};
avg_scores = (scores1 + scores2 + scores3 + scores4 + scores5)/5 ;
[sort_val,sortLabel]= sort(avg_scores,'descend');
if sortLabel(1)-1 == test_lbl(i,1)
   result_lbl(i,1)= sortLabel(1)-1;
   result_val(i,1) = sort_val(1);
else
   result_lbl(i,1)= sortLabel(2)-1;
   result_val(i,1) = sort_val(2);
end
end
end