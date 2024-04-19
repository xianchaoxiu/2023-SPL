function [X,lpq,optTime,iter,Obj] = ERCLP2(V,Ainput,lambda,weights,dim,options)
%% AMA for ERCLP
% min_{X,L} 0.5*|X-V|_F^2 + lambda sum_{(i,j)\in E}w_ij[l_ij|Xp-Xq|_2 + phi(l_ij)]
% AMA: Alternating minimization algorithm;
% ERCLP: Enhanced Regularized Clustering with line process

fprintf('\n************************ Solving ERC model ************************\n')
%% initialization
% initial point: X = V, lpq = 1 \forall p,q \in E
npairs = length(weights);
X = V; lpq = ones(1,npairs); 
alpha = 0.5;
maxiter = 100;
obj0 = Comp_fval(X,lpq,V,Ainput,lambda,weights,alpha); % X,lpq是变量，其它的是目标函数中的参数
Obj = obj0;

%% start of optimization phase
starttime = tic;
iter = 0;
for i = 1:maxiter
    iter = iter+1;
    % Using ssemismooth Newton-CG augmented Lagrangian method for X-subproblem
    % D_SSNAL is a two phases method, s is the number of iterations in phase I 
    all_weight = lambda*lpq.*weights;
    [~,~,X_SSNAL] = SSNAL(Ainput,X,dim,all_weight,options); 
    X = X_SSNAL; 
    
    % update lpq
    AX = Ainput.Amap(X); % AX \IN R^{p*边数}
    L2norm_X = sqrt(sum(AX.*AX)); %AX每列的2范数构成的行向量
    lpq = (alpha ./ (alpha + L2norm_X)).^2;
    
    % compute objective
    [obj_iter,obj_loss,obj_r1,obj_r2] = Comp_fval(X,lpq,V,Ainput,lambda,weights,alpha);
    
    fprintf('Iter | Loss \t | Reg_term \t |  Reg_term \t | Obj \t | Time(s) \n')
    fprintf('%3d | %f  | %f | %f | %f | %3.2f \n',iter,obj_loss,obj_r1,obj_r2, obj_iter, toc(starttime))
   
    % check for stopping criteria
    if abs(Obj(end)-obj_iter) < 1e-3
        fprintf('alpha = %f, lambda = %f \n',alpha, lambda)
        break;
    end
    Obj = [Obj,obj_iter];
end
optTime = toc(starttime);
end


function [obj_fval,obj_loss,obj_r1,obj_r2] = Comp_fval(X,lpq,V,Ainput,lambda,weights,alpha)
Fnorm = @(x) mexFnorm(x); obj_loss = 0.5*Fnorm(X - V)^2;
%obj_loss = 0.5*sum(sum(X_V.*X_V));
AX = Ainput.Amap(X); all_weight = lpq.*weights;
obj_r1 = lambda*sum(all_weight.*(sqrt(sum(AX.*AX))));
fval_phi = (sqrt(lpq) - 1).^2;
obj_r2 = lambda*alpha*sum(fval_phi.*weights);
obj_fval = obj_loss + obj_r1 + obj_r2;
end
