function [ w, lambda ] = get_RLS_linear_predictor(Xtrain, Ytrain, lower, upper, step, k)
%Returns the corresponding predictor w from RLS
% 

lambdas = [lower: step: upper];
for lambda = lambdas
    
end

end

function [w, error] = getKCVError(X_train, Y_train, lambda, k)
    [n d] = size(Xtrain);
    validation_step = n/k;
    for i = indices
        if i == 1
            X_cv = X_train(i:i+validation_step - 1);
            X_cv_train = X_train(i+validation_step:n);
            Y_cv = Y_train(i:i+validation_step - 1);
            Y_cv_train = Y_train(i+validation_step:n);
        elseif i == n + 1 - validation_step
            X_cv = X_train(i:n);
            X_cv_train = X_train(0:i-1);
            Y_cv = Y_train(i:n);
            Y_cv_train = Y_train(0:i-1);
        else
            X_cv = X_train(i:i+validation_step - 1);
            X_cv_train1 = X_train(1:i-1);
            Y_cv_train2 = Y_train(i+validation_step:n);
            Y_cv_train = [Y_cv_train1 X_cv_train2];
            
            Y_cv = Y_train(i:i+validation_step - 1);
            Y_cv_train1 = Y_train(1:i-1);
            Y_cv_train2 = Y_train(i+validation_step:n);
            Y_cv_train = [Y_cv_train1 Y_cv_train2];
        end
        %train
        w = inv(X_cv_train'*X_cv_train + lambda*n*I)*(X_cv_train'*Ytrain);
        %A\b === inv(A)*b
        %w = (X_cv_train'*Ytrain)\(X_cv_train'*X_cv_train + lambda*n*I);
    end
end

function [w] = train(X_train, Y_train, lambda)
    %w = inv(X_cv_train'*X_cv_train + lambda*n*I)*(X_cv_train'*Ytrain); %A\b === inv(A)*b
    w = (X_train'*X_train + lambda*n*I)\(X_train'*Y_train);
end 



