load UTKinect_LOSOCV_ColorSklMHI_RJI_Data.mat
%% WRITING TO HDF5
% for Color Skl-MHI data
name='UTKinect_ColorSklMHI_T15_P1';
% for RJI data
% name='UTKinect_RJI_1_T15_P1';
filename=[ name '.h5'];
% filename=[ name '.h5'];

chunksz=10;
num_total_samples= floor(length(all_labels_P9)/chunksz)*chunksz;
all_datas  = ColorSklMHI_P9;
all_labels = all_labels_P9;
kk = randperm(num_total_samples);
N = 62;
N_j = 62;
N_Ch=3;

train_img1=double(all_datas(kk,:));
train_lbl1=all_labels(kk,:);
data_ = reshape(train_img1',N,N_j,N_Ch,num_total_samples);
% data_disk = permute(data_disk,[2,1,3,4]); 
% data_disk = data_ -  double(mean_img);
data_disk = data_;
label_disk= double(train_lbl1');

created_flag=false;
totalct=0;

for batchno=1:num_total_samples/chunksz
  
  fprintf('batch no. %d\n', batchno);
  last_read=(batchno-1)*chunksz;

  % to simulate maximum data to be held in memory before dumping to hdf5 file 
  batchdata=data_disk(:,:,:,last_read+1:last_read+chunksz); 
  batchlabs=label_disk(:,last_read+1:last_read+chunksz);

  % store to hdf5
  startloc=struct('dat',[1,1,1,totalct+1], 'lab', [1,totalct+1]);
  curr_dat_sz=store2hdf5(filename, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
  created_flag=true;% flag set so that file is created only once
  totalct=curr_dat_sz(end);% updated dataset size (#samples)
end

% display structure of the stored HDF5 file
h5disp(filename);

%% READING FROM HDF5

% Read data and labels for samples #1000 to 1999
data_rd=h5read(filename, '/data', [1 1 1 10], [N, N_j, 3, 10]);
label_rd=h5read(filename, '/label', [1 10], [1, 10]);
fprintf('Testing ...\n');

try 
  assert(isequal(data_rd, double(data_disk(:,:,:,10:19))), 'Data do not match');
  assert(isequal(label_rd, double(label_disk(:,10:19))), 'Labels do not match');

  fprintf('Success!\n');
catch err
  fprintf('Test failed ...\n');
  getReport(err)
end
% delete(filename);
% CREATE list.txt containing filename, to be used as source for HDF5_DATA_LAYER
FILE=fopen([ name '.txt'], 'w');
fprintf(FILE, '%s', filename);
fclose(FILE);
fprintf('HDF5 filename listed in %s \n', filename);