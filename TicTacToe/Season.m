classdef Season
    %SEASON Summary of this class goes here
    %   Detailed explanation goes here

    properties
        NumOfBots
        BotArray
        mutateRate
        numOfGenerations
    end

    methods
        function obj = Season(numOfBots, mutateRate, numOfGenerations)
            obj.NumOfBots = numOfBots;
            obj.BotArray = TicTacToeBot.empty(numOfBots, 0);
            for i = 1:numOfBots
                obj.BotArray(i) = TicTacToeBot();
            end
            obj.mutateRate = mutateRate;
            obj.numOfGenerations = numOfGenerations;
        end

        function obj = RunSeason(obj)
            rounds = log2(length(obj.BotArray));
            ST = Swiss(obj.BotArray, rounds); 

            obj.BotArray = ST.runTournament();
        end

        function obj = breed(obj)
            len = length(obj.BotArray);
            factor = obj.NumOfBots/len;
            k = len+ 1;
            for i = 1:len
                tempBot = obj.BotArray(i).Brain;
                w = tempBot.weights;
                b = tempBot.biases;
                for j = 1:factor
                    [weights_new, biases_new] = mutate(w,b, obj.mutateRate);
                    obj2 = obj.BotArray(i);

                    obj2.Brain.weights = weights_new;
                    obj2.Brain.biases = biases_new;
                    obj.BotArray(k) = obj2;
                    k = k + 1;
                end
            end
        end

        function obj = RunGenerations(obj)
            for i = 1:obj.numOfGenerations
                if (mod(i, 100000) == 0)
                    obj.mutateRate = obj.mutateRate * .1;
                end
                obj = obj.RunSeason();
                if (mod(i,10000) == 0)
                    fileName = "results/G" + i+ ".mat";
                    save(fileName, "obj");
                end
                obj = obj.breed();
            end
        end

    end
end

