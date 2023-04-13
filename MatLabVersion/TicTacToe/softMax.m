%SoftMax transfer function
%pretty cool how simple it is
function [outputVector] = softMax(inputVector)
mx=max(inputVector);
inputVector=inputVector-mx;
outputVector=exp(inputVector)/sum(exp(inputVector));
end