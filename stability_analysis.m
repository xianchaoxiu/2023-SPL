% the number of nearest neighbors: floor(dim.n/(1+c*k)),c=0.2,0.4,0.6,0.8,1.0,
clear, clc, 

% Seeds, lambda = ;
% acc= [86.52, 86.52, 86.52, 86.52, 85.96, 86.52, 87.08, 85.96, 85.96,85.96]';
% ri = [90.49, 90.49, 90.49, 90.49, 89.81, 90.49, 90.81, 90.19, 90.19,90.19]';
% fs = [83.95, 83.95, 83.95, 83.95, 82.82, 83.95, 84.57, 83.35, 83.35,83.35]';
% jac= [72.34, 72.34, 72.34, 72.34, 70.68, 72.34, 73.26, 71.45, 71.45,71.45]';
% Wine,lambda = 5;
% acc= [86.52, 86.52, 86.52, 86.52, 85.96, 86.52, 87.08, 85.96, 85.96,85.96]';
% ri = [90.49, 90.49, 90.49, 90.49, 89.81, 90.49, 90.81, 90.19, 90.19,90.19]';
% fs = [83.95, 83.95, 83.95, 83.95, 82.82, 83.95, 84.57, 83.35, 83.35,83.35]';
% jac= [72.34, 72.34, 72.34, 72.34, 70.68, 72.34, 73.26, 71.45, 71.45,71.45]';
% Zoo,lambda = 17;
% acc= [83.17, 83.17, 82.18, 82.18, 82.18, 82.18, 82.18, 74.26, 74.26,74.26]';
% ri = [95.33, 95.33, 94.61, 94.61, 94.61, 94.61, 94.61, 90.18, 90.18,90.18]';
% fs = [89.04, 89.04, 87.16, 87.16, 87.16, 87.16, 87.16, 73.81, 73.81,73.81]';
% jac= [80.25, 80.25, 77.24, 77.24, 77.24, 77.24, 77.24, 58.49, 58.49,58.49]';
% boxplot([acc,ri,fs,jac],{'ACC','RI','F-score','Jaccard'})
% % metrics = {'ACC','RI','F-score','Jaccard'};
% % boxplot([acc,ri,fs,jac],metrics)
% title('Wine')

metrics = {'ACC','RI','F-score','Jaccard'};
x = [1:1:5];
%Agg:
ACC=[98.48; 97.97; 96.32; 80.46; 72.08];
RI = [99.47; 99.27; 98.61; 92.16; 88.08];
FS = [98.76; 98.28; 96.68; 77.88; 62.02];
JAC=[97.55; 96.61; 93.58; 63.78; 44.95];
figure(1);
subplot(1,2,1)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
title('Aggregation')
xlabel('c');
axis([1,5,min(JAC)-10,max(RI)+10])
ylf_legend = legend('ACC','RI','F-score','Jaccard');
%set(ylf_legend,'Interpreter','latex');
%set(gca, 'YGrid', 'on');
%set(gca, 'XGrid', 'on');

%Nonlinear:
ACC=[76.01; 77.33; 77.42; 69.43; 64.53];
RI = [91.66; 92.48; 92.68; 92.10; 92.00];
FS = [80.48; 82.12; 81.88; 78.56; 77.49];
JAC=[67.33; 69.66; 69.32; 64.70; 63.25];
subplot(1,2,2)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Nonlinear')

%Ecoli:
ACC=[76.79; 76.79; 75.89; 75.60; 74.70];
RI =  [90.09; 90.08; 89.39; 89.49; 89.17];
FS = [82.35; 82.34; 80.84; 80.94; 80.14];
JAC=[70.00; 69.98; 67.84;67.99; 66.87];
figure(2);
subplot(1,2,1)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Ecoli')

%Glass: 
ACC=[46.73; 46.73; 46.73; 47.20; 47.20];
RI =  [61.11; 61.11; 61.79; 61.88; 61.88];
FS = [52.21; 52.21; 52.65; 52.81; 52.81];
JAC=[35.33; 35.33; 35.73; 35.88; 35.88];
subplot(1,2,2)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Glass')

%Image:
ACC=[51.43; 51.43; 51.43; 51.43; 51.43];
RI =  [82.63; 82.63; 82.63; 82.63; 82.66];
FS = [49.74; 49.74; 49.74; 49.74; 49.56];
JAC=[33.11; 33.11; 33.11; 33.11; 32.95];
figure(3);
subplot(1,2,1)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Image')

%Ionosphere:
ACC=[63.49; 63.49; 63.49; 63.49; 63.49];
RI =  [73.80; 73.80; 73.80; 73.80; 73.80];
FS = [76.17; 76.17; 76.17; 76.17; 76.17];
JAC=[61.51; 61.51; 61.51; 61.51; 61.51];
subplot(1,2,2)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Ionosphere')

%Seeds:
ACC=[87.62; 87.62; 87.62; 86.67; 87.62];
RI =  [88.33; 88.33; 88.33; 87.89; 88.56];
FS = [81.41; 81.41; 81.41; 80.55; 81.68];
JAC=[68.65; 68.65; 68.65; 67.44; 69.03];
figure(4);
subplot(1,2,1)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Seeds')

%Soybean:
ACC=[100.00; 100.00; 100.00; 100.00; 100.00];
RI =  [100.00; 100.00; 100.00; 100.00; 100.00];
FS = [100.00; 100.00; 100.00; 100.00; 100.00];
JAC=[100.00; 100.00; 100.00; 100.00; 100.00];
subplot(1,2,2)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Soybean')

%Wine:
ACC=[86.52; 86.52; 86.52; 86.52; 86.52];
RI =  [90.49; 90.49; 90.49; 90.49; 90.49];
FS = [83.95; 83.95; 83.95; 83.95; 83.95];
JAC=[72.34; 72.34; 72.34; 72.34; 72.34];
figure(5);
subplot(1,2,1)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Wine')

%Zoo:
ACC=[83.17; 83.17; 82.18; 82.18; 82.18];
RI =  [95.33; 95.33; 94.61; 94.61; 94.61];
FS = [89.04; 89.04; 87.16; 87.16; 87.16];
JAC=[80.25; 80.25; 77.24; 77.24; 77.24];
subplot(1,2,2)
plot(x,ACC,'-rs','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,RI,'-k.','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,FS,'-gv','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
plot(x,JAC,'-bp','MarkerSize',6,'MarkerFaceColor','r','LineWidth',1);
hold on;
axis([1,5,min(JAC)-10,max(RI)+10])
xlabel('c');
title('Zoo')




