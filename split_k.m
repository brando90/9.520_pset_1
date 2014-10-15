function [X_cv_train, X_cv, Y_cv_train, Y_cv] = split_k(i, k, X_train, Y_train)
    s = size(X_train); %[n d]
    n = s(1);
    validation_step = n/k;
    if i == 1
        X_cv = X_train(i:i+validation_step - 1,:);
        X_cv_train = X_train(i+validation_step:n,:);
        Y_cv = Y_train(i:i+validation_step - 1,:);
        Y_cv_train = Y_train(i+validation_step:n,:);
    elseif i == n + 1 - validation_step
        X_cv = X_train(i:n,:);
        X_cv_train = X_train(1:i-1, :);
        Y_cv = Y_train(i:n,:);
        Y_cv_train = Y_train(1:i-1,:);
    else
        X_cv = X_train(i:i+validation_step - 1,:);
        X_cv_train1 = X_train(1:i-1,:);
        X_cv_train2 = X_train(i+validation_step:n,:);
        X_cv_train = [X_cv_train1 ; X_cv_train2];

        Y_cv = Y_train(i:i+validation_step - 1);
        Y_cv_train1 = Y_train(1:i-1);
        Y_cv_train2 = Y_train(i+validation_step:n);
        Y_cv_train = [Y_cv_train1 ; Y_cv_train2];
    end
end

