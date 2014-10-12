function [ w, lambda ] = get_RLS_linear_predictor(Xtrain, Ytrain, lower, upper, k)
%Returns the corresponding predictor w from RLS
% 

lambdas = [lower: step: upper];
[n d] = size(Xtrain);
I = eye(d);

for lambda = lambdas
    w = inv(Xtrain'*Xtrain + lambda*n*I)*(Xtrain'*Ytrain);
    
end

end

function [ w, lambda ] = get_RLS_linear_predictor(Xtrain, Ytrain, lower, upper, k)
%Returns the corresponding predictor w from RLS
% 

lambdas = [lower: step: upper];
[n d] = size(Xtrain);
I = eye(d);

for lambda = lambdas
    w = inv(Xtrain'*Xtrain + lambda*n*I)*(Xtrain'*Ytrain);
    
end

end

