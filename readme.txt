Deep Learning for Recognizing Human Activities using Motions of Skeletal Joints

This page describes about the detail parameters for creating the datasets that presented in the paper with the title "Deep Learning for Recognizing Human Activities using Motions of Skeletal Joints" which has been submitted to IEEE Transaction on Consumer Electronic.
The proposed system used two types of inputs Color Skeleton Motion History Image (Color Skl-MHI) and Relative Joint Image (RJI) for training in deep convolutional neural network trained by using Matcaffe framework for the recognition of human daily activity using depth sensor.
The experimental datasets are created based on the data provided by UTKinect Action-3D and CAD60 dataset. Because of the skeletal structure given by 2 datasets are different, we separately perform features extraction (Color Skl-MHI and RJI), training and testing on each dataset but the algorithms that have been used are the same.
--------------------------------------------------------------------------------------
Content:
1. Downloading the Datasets
2. Creation of Color Skl-MHI and RJI Dataset on UTKinect Action-3D Dataset
3. Creation of Color Skl-MHI and RJI Dataset on CAD60 Dataset
4. Separation of Training and Test Data
5. Creation of hdf5 database on UTKinect Action-3D Dataset
6. Creation of hdf5 database on CAD60 Dataset
7. Training 3D-DCNN on UTKinect Action-3D Dataset
8. Training 3D-DCNN on CAD60 Dataset
9. Testing 3D-DCNN on UTKinect Action-3D Dataset
10.Testing 3D-DCNN on CAD60 Dataset
--------------------------------------------------------------------------------------
1. Downloading the Datasets
1.1 UTKinect Action3D Dataset
UTKinect Action3D dataset can be downloaded at: http://cvrc.ece.utexas.edu/KinectDatasets/HOJ3D.html. After downloading, copy the "joints" folder into the datasets\UTKinect\ folder.
Then, separate actionLabel.txt file into 20 files (s01_e01.txt, s01_e02.txt, etc...) where each file contains (action: start_Frame end_Frame) information and copy to datasets\UTKinect\actions\ folder.

1.2 CAD60 Dataset
CAD60 dataset can be downloaded at: http://pr.cs.cornell.edu/humanactivities/data.php. After downloading the dataset, copy the skeleton coordinate file .txt under the "data1, data2, data3 and data4" folders into the datasets\CAD60\ folder. Modify each txt file by adding the action number in front of the file. (For example: 0_0512172825.txt which contain skeletal joints coordinates of action "still"). The number for each action is as follow: 
0.	Still
1.	rinsing mouth
2.	brushing teeth
3.	wearing contact lenses
4.	talking on phone
5.	drinking water
6.	opening pill container
7.	cooking(chopping)
8.	cooking(stirring)
9.	talking on couch
10.	relaxing on couch
11.	writing on whiteboard
12.	working on computer
--------------------------------------------------------------------------------------
2. Creation of Color Skl-MHI and RJI Dataset on UTKinect Action-3D Dataset
For converting the 3D joint coordinate of URKinect Action-3D dataset, we need to download "Kin2" from this URL: https://github.com/jrterven/Kin2 and copy into the "tools" folder. Then, the creation of Color Skl-MHI and RJI Dataset on UTKinect Dataset can be done by running experiments\UTKinect\Create_ColorSklMHI_RJI_UTKinect.m file and the extracted Color Skl-MHI and RJI of UTKinect dataset will be stored in ColorSklMHI_RJI_UTKinect.mat which can be downloaded at:
https://drive.google.com/file/d/1pOg_ABh7JaqBzGEQ8BtYa3CVoEIAtwPn/view?usp=sharing
--------------------------------------------------------------------------------------
3. Creating Color Skl-MHI and RJI Dataset on CAD60 Dataset
The creation of Color Skl-MHI and RJI Dataset on CAD60 Dataset can be done by running experiments\CAD60\Create_ColorSklMHI_RJI_CAD60.m file and the extracted Color Skl-MHI and RJI of CAD60 dataset will be stored in ColorSklMHI_RJI_CAD60.mat which can be downloaded at:
https://drive.google.com/file/d/1PdktPgnFGkYUktrXJjUfx-j0nGwbvyqY/view?usp=sharing
--------------------------------------------------------------------------------------
4. Separation of Training and Test Data
For training and testing the proposed system using the method of "Leave-One-Subject-Out-Cross-Validation", we separate the training and test data according to leave-one-person-out rule.

4.1 Separation of Training and Test Data on UTKinect Action3D Dataset
UTKinect Action3D dataset include 10 subjects who performed the actions. Therefore, we performed 10 experiments by separating the training and testing data as follow:
Training People 				Test Person
P2,P3,P4,P5,P6,P7,P8,P9,P10		P1
P1,P3,P4,P5,P6,P7,P8,P9,P10		P2
P1,P2,P4,P5,P6,P7,P8,P9,P10		P3
P1,P2,P3,P5,P6,P7,P8,P9,P10		P4
P1,P2,P3,P4,P6,P7,P8,P9,P10		P5
P1,P2,P3,P4,P5,P7,P8,P9,P10		P6
P1,P2,P3,P4,P5,P6,P8,P9,P10		P7
P1,P2,P3,P4,P5,P6,P7,P9,P10		P8
P1,P2,P3,P4,P5,P6,P7,P8,P10		P9
P1,P2,P3,P4,P5,P6,P7,P8,P9			P10
The separation of Training and Test Data on UTKinect Action3D dataset can be done by running experiments\UTKinect\Separate_Person_UTKinect.m file. After running program, all training and test data will be save into the UTKinect_LOSOCV_Clip_ColorSklMHI.mat file.
--------------------------------------------------------------------------------------
4.2 Separation of Training and Test Data on UTKinect Action3D Dataset
CAD60 dataset include 4 subjects who performed the actions. Therefore, we performed 4 experiments by separating the training and testing data as follow:
Training People 		Test Person
P2,P3,P4			P1
P1,P3,P4			P2
P1,P2,P4			P3
P1,P2,P3			P4
The separation of Training and Test Data on CAD60 dataset can be done by running experiments\CAD60\Separate_Person_CAD60.m file. After running program file, all training and test data will be save into the CAD60_LOSOCV_Clip_ColorSklMHI.mat file.
--------------------------------------------------------------------------------------
5. Creation of hdf5 database on UTKinect Dataset
For training the 3D-DCNN, we need to create hdf5 database for each training and test set. The creation of hdf5 database on UTKinect Dataset can be done by running experiments\UTKinect\Create_hdf5Database_ColorSklMHI_RJI_UTKinect.m file which will generate .h5 and .txt file for each training and test data. For creating the hdf5 database, we need to use the function "store2hdf5.m" provided in Matcaffe framework and copy into the same folder. Read and update some comments line for creating the hdf5 database for both Color Skl-MHI and RJI of UTKinect Action-3D dataset. We need to create 10 hdf5 database for each person. So, the total database files are 10 (.h5) x 10 (People) = 100 files. For example:
a.	UTKinect_ColorSklMHI_T15_NotP1
b.	UTKinect_ColorSklMHI_T15_P1
c.	UTKinect_RJI_1_T15_NotP1
d.	UTKinect_RJI_1_T15_P1
e.	UTKinect_RJI_2_T15_NotP1
f.	UTKinect_RJI_2_T15_P1
g.	UTKinect_RJI_3_T15_NotP1
h.	UTKinect_RJI_3_T15_P1
i.	UTKinect_RJI_4_T15_NotP1
j.	UTKinect_RJI_4_T15_P1 
--------------------------------------------------------------------------------------
6. Creation of hdf5 database on CAD60 Dataset
For training the 3D-DCNN, we need to create hdf5 database for each trainig and test set. This can be done by running experiments\CAD60\Create_hdf5Database_ColorSklMHI_RJI_CAD60.m file which will generate .h5 and .txt file for each trainig and test data. For creating the hdf5 database, we need to use the function "store2hdf5.m " provided in Matcaffe framework and copy into the same folder. Read and update some comments line for creating the hdf5 database for both Color Skl-MHI and RJI of CAD60 dataset. We need to create 10 hdf5 database for each person. So, the total database files are 10 (.h5) x 4 (People) = 40 files. For example:
a.	CAD60_ColorSklMHI_T15_NotP1
b.	CAD60_ColorSklMHI_T15_P1
c.	CAD60_RJI_1_T15_NotP1
d.	CAD60_RJI_1_T15_P1
e.	CAD60_RJI_2_T15_NotP1
f.	CAD60_RJI_2_T15_P1
g.	CAD60_RJI_3_T15_NotP1
h.	CAD60_RJI_3_T15_P1
i.	CAD60_RJI_4_T15_NotP1
j.	CAD60_RJI_4_T15_P1
--------------------------------------------------------------------------------------
7. Training 3D-DCNN on UTKinect Dataset
After creating the hdf5 database of Color Skl-MHI and RJI from the UTKinect Dataset, we can train 3D-DCNN for Color Skl-MHI and RJI by running the experiments\UTKinect\Train_DCNN_ColorSklMHI_RJI_UTKinect.m file. We need to train 5 caffemodels for each person as follow:
a.	UTKinect_ColorSklMHI_NotP1
b.	UTKinect_RJI_1_NotP1
c.	UTKinect_RJI_2_NotP1
d.	UTKinect_RJI_3_NotP1
e.	UTKinect_RJI_4_NotP1
Therefore, the total trained models are 5 x 10 (people) = 50 caffemodels which can be downloaded at:
https://drive.google.com/file/d/1BOwAuIVsjx57wmjvcwTbtOsXOq4_DLfW/view?usp=sharing
--------------------------------------------------------------------------------------
8. Training 3D-DCNN on CAD60 Dataset
After creating the hdf5 database of Color Skl-MHI and RJI from the CAD60 dataset, we can train 3D-DCNN for Color Skl-MHI and RJI by running the experiments\CAD60\Train_DCNN_ColorSklMHI_RJI_CAD60.m file. We need to train 5 caffemodels for each person as follow:
a.	CAD60_ColorSklMHI_NotP1
b.	CAD60_RJI_1_NotP1
c.	CAD60_RJI_2_NotP1
d.	CAD60_RJI_3_NotP1
e.	CAD60_RJI_4_NotP1
Therefore, the total trained models is 5 x 4 (people) = 20 caffemodels which can be downloaded at:
https://drive.google.com/file/d/16Wxh8Cp03_nC7MbPiRMJRmtuGat5x2wv/view?usp=sharing
--------------------------------------------------------------------------------------
9. Testing 3D-DCNN on UTKinect Action-3D Dataset
Trained 3D-DCNN on UTKinect Action-3D dataset can be tested by running the experiments\UTKinect\Test_DCNN_ColorSklMHI_RJI_UTKinect.m file. For calculating the overall accuracy, please change person id and caffemodels.
--------------------------------------------------------------------------------------
10.Testing 3D-DCNN on CAD60 Dataset
Trained 3D-DCNN on CAD60 dataset can be tested by running the experiments\CAD60\Test_DCNN_ColorSklMHI_RJI_CAD60.m file. For calculating the overall accuracy, please change person id and caffemodels.
--------------------------------------------------------------------------------------
