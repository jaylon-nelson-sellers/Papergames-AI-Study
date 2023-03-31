classdef adjustLearningRate
    %     Adjusts the Current Learning Rate

    properties

        adjustBoolean = true;
        %Lowest Recently observed Mean Square Error
        LowestMSE = -1;
        %Current Mean Square Error
        CurrentMSE = 0;

        %How many times the Mean Square Error hasn't improved
        strikes = 0;
        %Max number of strikes before resetting
        maxStrikes = 0;

        %LearningRate to return
        newLearningRate = 0;
    end

    methods
        %This function creates a ALR object
        function ALR = adjustLearningRate(adjustB, s, mS, LR)
            ALR.adjustBoolean = adjustB;
            ALR.strikes = s;
            ALR.maxStrikes = mS;
            ALR.LowestMSE = -1;
            ALR.newLearningRate = LR;

        end

        %this function adjusts the learning rate based on the Mean Square
        %Error
        %@param MSE to be observed
        %@param learningRate to modify
        %@return a modified ALR object
        function adjusted = adjust(obj,MSE, learningRate)

            if (obj.adjustBoolean == false)
                obj.newLearningRate = learningRate;
                adjusted = obj;
                return;
            end
            %if the learning Rate is too low, don't change
            if (learningRate <= 10^-6)
                obj.newLearningRate = 10^-6;
                adjusted = obj;
                return;
            end
            %Initilize the LowestMSE observed,
            %i.e first iteration
            if (obj.LowestMSE == -1)
                obj.LowestMSE = MSE;
                obj.newLearningRate = learningRate;
                obj.strikes = 0;
                %checks if the current MSE is higher
                %if so this means the algorithm hasn't improved, it gets a
                %strike
            elseif (MSE > obj.LowestMSE)
                obj.strikes = obj.strikes+ 1;
            else
                %else sets the MSE to the new lowest value and reset
                %Strikes
                obj.LowestMSE = MSE;
                obj.strikes = 0;
            end
            %if the strikes reaches the max, reset the counter and lower
            %the learningRate
            if (obj.strikes == obj.maxStrikes)
                obj.strikes = 0;
                obj.newLearningRate = learningRate * .5;
                % disp("New Learning Rate: " + learningRate);
                obj.LowestMSE = MSE;
            end

            adjusted = obj;
        end

        function adjusted = adjustOverEpochs(obj, learningRate, epoch)
            if (mod(epoch, 100) == 0)
                obj.newLearningRate = learningRate * .1;
            else
                obj.newLearningRate = learningRate;
            end
            adjusted = obj;
        end

        %returns the learningRate
        function LR = returnLearningRate(obj)
            LR = obj.newLearningRate;
        end


    end
end

