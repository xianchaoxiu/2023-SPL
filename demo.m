
clear, clc,  
data_dir = pwd;
addpath(strcat(pwd,'/Solver.p/'));
addpath(strcat(pwd,'/utils/'));
addpath(strcat(pwd,'/ClusterEvaluation/'));

%% ======= data loading =============== X\in R^{p*n},labels\in R^{n*1}
load(strcat(data_dir, '/Data/UCI/ecoli.mat')); 
%%ecoli,glass,ionosphere,seeds,soybean_small,wine,zoo,
%%Image_segmentation_1
% normalize X
X = zscore(X')';
dataMatrix = X;
[dim.d,dim.n] = size(dataMatrix);

%% Compute connection structure matrix
% k = max(labels);  k_n = floor(dim.n/(1+0.2*k));
k_n = dim.n-1;  %dim.n-1(the full connected structure), 
phi = 0.5;  %phi = 0 means that all weights are one.
fprintf('\n Start to compute weights.\n');
[weightVec1,NodeArcMatrix] = compute_weight(dataMatrix,k_n,phi,1); %weightVec1 \IN R^{1*边数}，NodeArcMatrix \IN R^{n*边数}

%% Construct Amap
A0 = NodeArcMatrix;
Ainput.A = A0;
Ainput.Amap = @(x) x*A0;
Ainput.ATmap = @(x) x*A0';
Ainput.ATAmat = A0*A0'; %%graph Laplacian
Ainput.ATAmap = @(x) x*Ainput.ATAmat;
dim.E = length(weightVec1);
options.stoptol = 1e-6; %% tolerance for terminating the algorithm(SSNAL)
options.use_kkt = 0;
options.maxiter = 100;
options.admm_iter = 20;

%% Mian
lambda_list = 0.023; 
nlambda = length(lambda_list);
cluster_id = zeros(dim.n,nlambda);
num_cluster = zeros(nlambda,1);
Acc = zeros(nlambda,1);
AMI = zeros(nlambda,1);
NMI = zeros(nlambda,1);
ARI = zeros(nlambda,1);
RI  =  zeros(nlambda,1);
Fscore = zeros(nlambda,1);
JI = zeros(nlambda,1);
Iter = zeros(nlambda,1);
Obj_value = cell(nlambda,1);
for i = 1:nlambda    
    % Solving optimization problem
    [X_ERC,lpq,optTime,Iter(i),Obj_value{i}] = ERCLP2(X,Ainput,lambda_list(i),weightVec1,dim,options);
    % find_cluster& computing evaluation indexes
    [cluster_id(:,i), num_cluster(i)] = find_cluster(X_ERC,1e-5);
    [Acc(i),AMI(i),NMI(i),ARI(i),RI(i),Fscore(i),JI(i)] = ClustEval(cluster_id(:,i), labels);
end
[BAcc, BAMI,BNMI,BARI,BRI, BFscore, BJI] = find_best_result(Acc, AMI, NMI, ARI, RI, Fscore, JI);

%% show the difference of Objective function
Diff_Fval = abs(Obj_value{1,1}(2:end)- Obj_value{1,1}(1:end-1));
save('Results/Agg_DFval.mat','Diff_Fval'); %函数值差分
len_D = length(Diff_Fval);
plot(1:len_D,Diff_Fval);

%% Other function
function [mAcc, mAMI,mNMI,mARI,mRI, mFscore, mJI] = find_best_result(VAcc, VAMI, VNMI, VARI, VRI, VFscore, VJI)
[mARI,index] = max(VARI);
mAcc = VAcc(index);
mAMI = VAMI(index);
mNMI = VNMI(index);
mRI  = VRI(index);
mFscore  = VFscore(index);
mJI  = VJI(index);
fprintf('\n********************* Output Results ************************')
fprintf('\n   ACC&    AMI&    NMI&    ARI&    RI&   Fscore&  Jaccard')
fprintf('\n %0.4f& %0.4f& %0.4f& %0.4f& %0.4f& %0.4f&  %0.4f \n',mAcc,mAMI,mNMI,mARI,mRI,mFscore,mJI)
fprintf('*************************************************************\n')
end



