function [ w, lambda ] = get_RLS_linear_predictor(Xtrain, Ytrain, lower, upper, step, k)
%Returns the corresponding predictor w from RLS
% 

lambdas = [lower: step: upper];
[n d] = size(Xtrain);
for lambda = lambdas
    %w = inv(Xtrain'*Xtrain + lambda*n*I)*(Xtrain'*Ytrain);
    validation_step = n/k;
    indices = [1:validation_step:n];
    for i = indices
        if i == 1
            X_cv = X_train(i:i+validation_step - 1);
            X_cv_train = X_train(i+validation_step:n);
        elseif i == n + 1 - validation_step
            X_cv = X_train(i:n);
            X_cv_train = X_train(0:i-1);
        else
            X_cv = X_train(i:i+validation_step - 1);
            X_cv_train1 = X_train(1:i-1);
            X_cv_train2 = X_train(i+validation_step:n);
            X_cvtrain = [X_cv_train1 X_cv_train2]
        end
    end
    
end

end

