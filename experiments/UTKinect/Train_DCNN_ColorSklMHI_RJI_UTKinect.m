warning off;
% train caffe model using GPU
addpath('C:/caffe/matlab');
caffe.set_mode_gpu();
gpu_id = 0; % we will use the first gpu
caffe.set_device(gpu_id);
% network architecture file for Color Skl-MHI data
% net = caffe.Net('utkinect_train_test_hdf5_ColorSklMHI.prototxt', 'train');
% network parameters file for Color Skl-MHI data
% solver = caffe.Solver('utkinect_ColorSklMHI_solver.prototxt');
% network architecture file for RJI data
net = caffe.Net('utkinect_RJI_train_test_hdf5.prototxt', 'train');
% network parameters file for RJI data
solver = caffe.Solver('utkinect_RJI_solver.prototxt');
% train 100000 iteration
solver.step(100000);
% get the network
train_net = solver.net;
% save network as caffemodel for Color Skl-MHI data
% train_net.save('../../models/UTKinect/UTKinect_ColorSklMHI_NotP1.caffemodel');
% save network as caffemodel for RJI data
train_net.save('../../models/UTKinect/UTKinect_RJI_4_NotP1.caffemodel');
% caffe.reset_all();