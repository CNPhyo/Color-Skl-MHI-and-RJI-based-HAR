function [RJ1Dif,RJ2Dif,RJ3Dif,RJ4Dif] = Fun_ExtractRJI1_4(JointIndices)
info_X = JointIndices(:,1);
info_Y = JointIndices(:,2);
info_Z = JointIndices(:,3);
X = info_X;
Y = info_Y;
Z = info_Z;
X5 = [X(1:3,1); X(5:20,1)];
Y5 = [Y(1:3,1) ; Y(5:20,1)];
Z5 = [Z(1:3,1); Z(5:20,1)];
X5Dif = abs(X5 - X(4,1));
Y5Dif = abs(Y5  - Y(4,1));
Z5Dif = abs(Z5  - Z(4,1));
RJ1Dif = [X5Dif;Y5Dif;Z5Dif];
X9 = [X(1:7,1); X(9:20,1)];
Y9  = [Y(1:7,1) ;  Y(9:20,1)];
Z9  = [Z(1:7,1) ;  Z(9:20,1)];
X9Dif = abs(X9 - X(8,1));
Y9Dif = abs(Y9  -  Y(8,1));
Z9Dif = abs(Z9  -  Z(8,1));
RJ2Dif = [X9Dif;Y9Dif;Z9Dif];
X13 = [X(1:11,1); X(13:20,1)];
Y13  = [Y(1:11,1) ;  Y(13:20,1)];
Z13  = [Z(1:11,1) ;  Z(13:20,1)]; 
X13Dif = abs(X13 - X(12,1));
Y13Dif = abs(Y13  - Y(12,1));
Z13Dif = abs(Z13  - Z(12,1));
RJ3Dif = [X13Dif;Y13Dif;Z13Dif];
X17 = [X(1:15,1); X(17:20,1)];
Y17  = [Y(1:15,1) ; Y(17:20,1)];
Z17  = [Z(1:15,1) ; Z(17:20,1)]; 
X17Dif = abs(X17 - X(16,1));
Y17Dif = abs(Y17  -  Y(16,1));
Z17Dif = abs(Z17  -  Z(16,1));
RJ4Dif = [X17Dif;Y17Dif;Z17Dif];
end