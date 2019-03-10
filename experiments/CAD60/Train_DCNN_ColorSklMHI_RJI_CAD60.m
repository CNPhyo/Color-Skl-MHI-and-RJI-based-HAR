warning off;
% add the path where matcaffe exist
addpath('C:/caffe/matlab');
% caffe.set_mode_cpu();
caffe.set_mode_gpu();
gpu_id = 0;
caffe.set_device(gpu_id);
% % network architecture file for Color Skl-MHI data
% net = caffe.Net('cad60_ColorSklMHI_train_test_hdf5.prototxt', 'train');
% % network parameters file for RJI data
% solver = caffe.Solver('cad60_ColorSklMHI_solver.prototxt');

% % network architecture file for RJI data
net = caffe.Net('cad60_RJI_train_test_hdf5.prototxt', 'train');
% % network parameters file for RJIdata
solver = caffe.Solver('cad60_RJI_solver.prototxt');

% % train 100000 iterations
solver.step(100000);
% % get the network
train_net = solver.net;
% % saving caffemodel for Color Skl-MHI data
% train_net.save('../../models/CAD60/CAD60_ColorSklMHI_NotP1.caffemodel');
% % saving caffemodel for RJI data 
train_net.save('../../models/CAD60/CAD60_RJI_1_NotP1.caffemodel');
caffe.reset_all();
