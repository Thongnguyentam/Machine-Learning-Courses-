function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
values = [0.01 0.03 0.1 0.3 1 3 10 30]'; %tao collumn
C= 0.1; sigma= 0.1;
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
predictions= svmPredict(model, Xval); %predict the labels on the cross validation set
meanMin = mean(double(predictions~= yval));
C_op= C;
sigma_op= sigma; %Record the sigma of the current minimum cost
for i= 2: length(values)
  for j=2: length(values)
    C = values(i);
    sigma = values(j);
    model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
    predictions= svmPredict(model, Xval);
    tam= mean(double(predictions~= yval));
    if (meanMin >= tam) 
      meanMin = tam; %prediction error
      C_op = C;
      sigma_op = sigma;
    end
  end
end
C= C_op;
sigma= sigma_op; % determine the best C and ? parameter to use.
% =========================================================================

end
