classdef Season
    %SEASON Summary of this class goes here
    %   Detailed explanation goes here

    properties
        BotArray
        mutateRate
        numOfGenerations
    end

    methods
        function obj = Season(numOfBots, mutateRate, numOfGenerations)
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

            ST.run_tournament();
        end

    end
end

