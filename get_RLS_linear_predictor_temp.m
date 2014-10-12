function [w, lambda] = get_RLS_linear_predictor_temp(X_train, Y_train, lower, upper, step, k)
%Returns the corresponding predictor w from RLS
% 
lambdas = [lower: step: upper];
best_lambda = Inf;
smallest_avg_cv_error = Inf;
for current_lambda = lambdas
    current_avg_cv_error = get_avg_KCV_Error(X_train, Y_train, current_lambda, k);
    if current_avg_cv_error < smallest_avg_cv_error
        best_lambda = current_lambda;
    end
end
lambda = best_lambda;
w = train_RLS(X_train, Y_train, lambda);
end

function [cv_error] = get_avg_KCV_Error(X_train, Y_train, lambda, k)
    [n, d] = size(X_train);
    validation_step = n/k;
    indices = [1:validation_step:n];
    cv_error = 0;
    X_cv_train = 0;
    X_cv = 0;
    Y_cv_train = 0; 
    Y_cv = 0;
    for i = indices
        X_cv_train, X_cv, Y_cv_train, Y_cv = split_k(i, k, X_train, Y_train);
        w = train_RLS(X_cv_train, Y_cv_train, lambda);
        current_cv_error = get_error(w, X_cv, Y_cv);
        cv_error = current_cv_error + cv_error;
    end
    %w = train_RLS(X_train, Y_train, lambda);
    cv_error = cv_error / length(indices);
end

function [w] = train_RLS(X_train, Y_train, lambda)
    %w = inv(X_cv_train'*X_cv_train + lambda*n*I)*(X_cv_train'*Ytrain); %A\b === inv(A)*b
    [n d] = size(X_train);
    I = eye(d);
    w = (X_train'*X_train + lambda*n*I)\(X_train'*Y_train);
end

function [error] = get_error(w, X_test, Y_test)
    error = norm(Y_test-X_test*w, 2);
end

function [X_cv_train, X_cv, Y_cv_train, Y_cv] = split_k(i, k, X_train, Y_train)
    [n, d] = size(X_train);
    validation_step = n/k;
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
        X_cv_train2 = X_train(i+validation_step:n);
        X_cv_train = [X_cv_train1 ; X_cv_train2];

        Y_cv = Y_train(i:i+validation_step - 1);
        Y_cv_train1 = Y_train(1:i-1);
        Y_cv_train2 = Y_train(i+validation_step:n);
        size(Y_cv_train1)
        size(Y_cv_train2)
        Y_cv_train = [Y_cv_train1 Y_cv_train2];
    end
end



