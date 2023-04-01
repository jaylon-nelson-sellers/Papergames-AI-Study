% BackpropNetwork
% a class that contains BackpropLayers
classdef BackpropNetwork
    properties
        transfer    % transfer function
        derTransfer % derivative of transfer function
        layers      % vector of layers
        learningRate
    end

    methods
        % BackpropNetwork
        % creates the network with numLayer # of layers
        % dimLayers - matrix of matrices representing the dimensions of
        %             each layer
        % transfer - matrix of transfer function to be used in the layers
        % derTransfer - matrix of derivative transfer functions to be used
        %               in the layers
        function obj = BackpropNetwork(numLayer, dimLayers, transfer, derTransfer)
            obj.transfer = transfer;
            obj.derTransfer = derTransfer;
            obj.layers = [];
            
            % create all layers except output layer using the dimensions from dimLayers
            for i = 1:numLayer - 1
                dim = dimLayers{i};
                obj.layers = [obj.layers BackpropLayer(dim(1), dim(2), obj.transfer{i}, obj.derTransfer{i}, i - 1, false)];
            end
            % create output layer
            dim = dimLayers{numLayer};
            obj.layers = [obj.layers BackpropLayer(dim(1), dim(2), obj.transfer{numLayer}, obj.derTransfer{numLayer}, numLayer - 1, true)];
        end

        % train
        % runs one iteration of training on the BackpropLayers
        function obj = train(obj, p, t, learningRate)
            p = p';
            t = t';

            % go forward through layers to get outputs (a)
            a = p;
            for i = 1:length(obj.layers)
                %fprintf("forward " + i + "\n");
                obj.layers(i) = obj.layers(i).forward(a);
                a = obj.layers(i).A;
            end

            % calculate sensitivities of each layer (backwards)
            % first do output layer with test (t) and prevLayer (None)
            %fprintf("backward " + length(obj.layers) + " - output layer\n");
            obj.layers(length(obj.layers)) = obj.layers(length(obj.layers)).backward(t, "None");

            % continue with other layers with test (None)
            % and prevLayer (i + 1)
            for i = length(obj.layers) - 1:-1:1
                %fprintf("backward " + i + "\n");
                obj.layers(i) = obj.layers(i).backward("None", obj.layers(i + 1));
            end

            % update weights and biases
            %might have thrown everything off here
            a = p;
            for i = 1:length(obj.layers)
                %fprintf("update layer " + i + "\n")
                obj.layers(i) = obj.layers(i).update(obj.learningRate, a);
                a = obj.layers(i).A;
            end
        end

        %Tests on an input without training network
        function obj = test(obj, p)
            a = p;
            for i = 1:length(obj.layers)
                %fprintf("testing layer " + i + "\n");
                obj.layers(i) = obj.layers(i).forward(a);
                a = obj.layers(i).A;
            end
        end

        function Output = getAnswer(obj,inputVector)
            obj = obj.test(inputVector');
            Output = (obj.layers(length(obj.layers)).A);
            [val, idx] = max(Output);
            Output = idx-1;
        end

        function Soft = getOutput(obj, inputVector)
            obj = obj.test(inputVector');
            Output = (obj.layers(length(obj.layers)).A);
            Soft = Output';
        end
    end
end


%       % train
%         % runs one iteration of training on the BackpropLayers
%         function obj = train(obj, p, t, learningRate)
%             p = p';
%             t = t';
% 
%             % go forward through layers to get outputs (a)
%             a = p;
%             for i = 1:length(obj.layers)
%                 %fprintf("forward " + i + "\n");
%                 obj.layers(i) = obj.layers(i).forward(a);
%                 a = obj.layers(i).A;
%             end
% 
%             % calculate sensitivities of each layer (backwards)
%             % first do output layer with test (t) and prevLayer (None)
%             %fprintf("backward " + length(obj.layers) + " - output layer\n");
%             obj.layers(length(obj.layers)) = obj.layers(length(obj.layers)).backward(t, "None");
% 
%             % continue with other layers with test (None)
%             % and prevLayer (i + 1)
%             for i = length(obj.layers) - 1:-1:1
%                 %fprintf("backward " + i + "\n");
%                 obj.layers(i) = obj.layers(i).backward("None", obj.layers(i + 1));
%             end
% 
%             % update weights and biases
%             %might have thrown everything off here
%             a = p;
%             for i = 1:length(obj.layers)
%                 %fprintf("update layer " + i + "\n")
%                 obj.layers(i) = obj.layers(i).update(obj.learningRate, a);
%                 a = obj.layers(i).A;
%             end
%         end