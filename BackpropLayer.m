% BackpropLayer
% a class used to represent one layer in the backpropagation network
classdef BackpropLayer
    properties
        id          % id of the layer (#'s 0, 1, 2, 3)
        layers
        transfer    % transfer function
        derTransfer % derivative of transfer function
        isOutput    % if layer is output layer
        W           % weight matrix
        B           % bias matrix
        A           % output matrix
        DA          % derivative output matrix
        S           % sensitivity matrix
        iSize       % identity matrix size
    end

    methods
        %constructor for backpropLayer
        function obj = BackpropLayer(dimR, dimC, transfer, derTransfer, id, isOutput)
            %relu

            limit = sqrt(6/(dimC));
            obj.W = -limit + (limit+limit) * rand(dimR, dimC);
            obj.B = -limit + (limit+limit) * rand(dimR, 1);
            obj.transfer = transfer;
            obj.derTransfer = derTransfer;
            obj.id = id;
            obj.isOutput = isOutput;
            obj.iSize = dimR;
        end

        % forward
        % perform forward operation
        function obj = forward(obj, p)
            n = (obj.W * p) + obj.B;
            obj.A = obj.transfer(n); % store output of
            obj.DA = diag(obj.derTransfer(n)); % store derivative output of layers
        end

        % backward
        % perform backward operation
        function obj = backward(obj, t, prevLayer)
            % if last layer we need to calculate error then sensitivity
            if obj.isOutput
                error = t - obj.A;
                s = -(2 * obj.DA * error);
            else
                s = obj.DA * prevLayer.W' * prevLayer.S;
            end
            % for logsig
            s = thresholdL2Norm(s,1);
            obj.S = s;
        end

        % update
        % update weights and biases using previous layer and learning rate
        function obj = update(obj, learningRate, lastA)
            obj.W = obj.W - (learningRate * obj.S * lastA');
            obj.B = obj.B - (learningRate * obj.S);
        end
    end
end
