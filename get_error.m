function [error] = get_error(w, X_test, Y_test)
    s = size(X_test);
    n = s(1);
    error = (1/n)*norm(Y_test-X_test*w, 2)^2;
end