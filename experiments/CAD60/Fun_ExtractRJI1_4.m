function[RJ1Dif,RJ2Dif,RJ3Dif,RJ4Dif] = Fun_ExtractRJI1_4(all_data)
all_Joints = all_data(1,2:46);
JointIndices = reshape(all_Joints,[15,3])/1000;
info_X = JointIndices(:,1);
info_Y = JointIndices(:,2);
info_Z = JointIndices(:,3);
% [TH,R,Z] = cart2pol(info_X,info_Y,info_Z);
X  = info_X;
Y  = info_Y;
Z  = info_Z;

X4  = [X(1:3,1); X(5:15,1)];
Y4  = [Y(1:3,1) ; Y(5:15,1)];
Z4  = [Z(1:3,1); Z(5:15,1)];
X4Dif  = abs(X4 - X(4,1));
Y4Dif  = abs(Y4  - Y(4,1));
Z4Dif  = abs(Z4  - Z(4,1));
RJ1Dif = [X4Dif;Y4Dif;Z4Dif];

X6  = [X(1:5,1); X(7:15,1)];
Y6  = [Y(1:5,1) ;  Y(7:15,1)];
Z6  = [Z(1:5,1) ;  Z(7:15,1)];
X6Dif  = abs(X6 - X(6,1));
Y6Dif  = abs(Y6  -  Y(6,1));
Z6Dif  = abs(Z6  -  Z(6,1));
RJ2Dif = [X6Dif;Y6Dif;Z6Dif];

X8  = [X(1:7,1); X(9:15,1)];
Y8  = [Y(1:7,1) ;  Y(9:15,1)];
Z8  = [Z(1:7,1) ;  Z(9:15,1)];
X8Dif  = abs(X8 - X(8,1));
Y8Dif  = abs(Y8  - Y(8,1));
Z8Dif  = abs(Z8  - Z(8,1));
RJ3Dif = [X8Dif;Y8Dif;Z8Dif];

X10  = [X(1:9,1); X(11:15,1)];
Y10  = [Y(1:9,1) ; Y(11:15,1)];
Z10  = [Z(1:9,1) ; Z(11:15,1)];
X10Dif  = abs(X10 - X(10,1));
Y10Dif  = abs(Y10  -  Y(10,1));
Z10Dif  = abs(Z10  -  Z(10,1));
RJ4Dif  = [X10Dif;Y10Dif;Z10Dif];
end

