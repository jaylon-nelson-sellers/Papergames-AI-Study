classdef PerceptronLayer

    properties
        %         learningRate is the incremental difference from each incorrect
        %         output. Each backwards propagation increases or decreases based
        %         on errorRate
        learningRate;

        %         How many times the program runs the backpropagation
        n_iterations;

        %         total number of inputs
        inputs

        %         total number of outputs
        outputs

        %         Matrix of weights to be multiplied
        weights

        %         vector of biases to be added to outputs
        biases

        MSE

        MSEs

        %         string that determines what transfer function is used
        transferFunction
    end

    methods
        %         constructor 1
        %         param input1: either inputs (a scalar) or weights (a matrix)
        %         param input2: either outputs (a scalar) or biases (a vector)
        %         param transferFuction: string of the transfer function to be used
        %         return obj: Perceptron Object
        function obj=PerceptronLayer(input1, input2, transferFunction)
            size1 = size(input1);
            size2 = size(input2);
            %             create based on number of inputs/outputs
            if (size1(1) == 1 && size2(1) == 1 ...
                    && size1(2) == 1 && size2(2))
                obj.inputs = input1;
                obj.outputs = input2;

                obj.weights = (1--1)*rand(obj.outputs, obj.inputs)-1;
               % obj.weights = obj.weights * (1/obj.inputs);

                obj.biases = (1--1)*rand(1, obj.outputs)-1;
              %   obj.biases = obj.biases * (1/obj.inputs);
                %create based on weights and biases
            else
                obj.weights = input1;
                obj.biases = input2;

            end
            %helper function
            obj.transferFunction = transferFunction;
        end

        %         TransferFunction
        %         Sets the transfer function to be used
        %         @param input: The desired transfer Function
        %         @return TFOutput: a output based on the transfer function used,
        %         currently either hardlim or hardlims
        function TFOutput = TransferFunction(obj, input)
            switch obj.transferFunction
                case "hardlim"
                    TFOutput = hardlim(input);
                case "hardlims"
                    TFOutput = hardlims(input);
                case "purelin"
                    TFOutput = purelin(input);
                case "softmax"
                    TFOutput = softmax(input);
                   
            end
        end


        %         forward
        %         forward propagation method.
        %         @param inputVector: vector of values to be passed into Neurons
        %         @return fOutput: vector of outputs, based on
        %         input-neuron interaction
        function fOutput = forward(obj, inputVector)

            %creates tempory Vector from Neuron's output from input vector
            tempVector = Neuron(inputVector, obj.weights, obj.biases);

            %passed vector through transfer function
            %returns value
            fOutput = obj.TransferFunction(tempVector);
        end
        
         function fOutput = getOutput(obj,inputVector)
            fOutput = forward(obj, inputVector);
        end
        
        function fOutput = getPureLin(obj,inputVector)
            fOutput = forward(obj, inputVector);
            fOutput = round(fOutput);
        end

        function fOutput = getAnswer(obj,inputVector)
            fOutput = forward(obj, inputVector);
            [val, idx] = max(fOutput);
            fOutput = idx-1;
        end
        %         print
        %         print weight and bias function
        %         The function is used to print the PerceptronLayer's weight and
        %         bias in a clear way
        function print(obj)
            disp("==================================")
            disp("Weight Size: ")
            disp(size(obj.weights))
            disp("Weight: ")
            disp(obj.weights)
            disp("Bias Size: ")
            disp(size(obj.biases))
            disp("Bias: ")
            disp(obj.biases)
            disp("==================================")
        end


        %        errorLoss
        %        Error Loss Function
        %        Takes actual output and compares to target output
        %        subtracts to get the error loss values
        %        @param a: a vector of the actual output (a)
        %        @param t: a vector of the desired output (t)
        %        @return errorVector: a vector of the error loss values based on
        %        a and t
        function errorVector= errorLoss(~, a , t)
            errorVector = t-a;
        end


        %        fit
        %        fits the Perceptron to the dataSet given
        %        @param dataSet: input vector to be observed and to fit the Perceptron
        %        @param answerSet: desired output vector (t vector) to be used to
        %        compare actual outputs
        %        @return fitness score
        function trained = train(obj, dataSet, answerSet)
            %        2)iterates through dataSet, and sets the input on the current data
            for idx = 1:size(dataSet)
                currentInputs = dataSet(idx,:);

                %        3)forwards that input, saves the output vector
                linearOutput = obj.forward(dataSet(idx,:));

                %        4)Creates a error loss vector based on the above output
                errorVector = obj.errorLoss(linearOutput, answerSet(idx,:));


                %          squareErrors = squareErrors + square(errorVector);
                %        5)adjusts values based on errorVector
                obj = obj.backward(errorVector, currentInputs);
            end

           trained = obj;
        end


        % backward
        % backward propagation method
        % adjusts weights and biases based on error loss
        % 1) checks if errorVector is the same size of Neurons (outputs should match)
        % 2) creates a update
        function backwardReport = backward(obj, errorVector, currentInputs)
            %updates the values
            update = (obj.learningRate * errorVector);
            updatedWeights = update' * currentInputs;
            obj.weights = obj.weights + updatedWeights;
            obj.biases = obj.biases + update;
            backwardReport = obj;
        end
    end



end


