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
            obj.BotArray = repmat(TicTacToeBot(), numOfBots, 1);
            obj.mutateRate = mutateRate;
            obj.numOfGenerations = numOfGenerations;
        end

        function obj = RunSeason(obj)
            obj = obj.sort();
            ST = SwissTournament(obj.BotArray); log2(Size(obj.BotArray));
            ST.run_tournament();
        end

        function obj = sort(obj)
            [~, sorted_idx] = sort([obj.BotArray.score]);
            obj.BotArray = my_objects(sorted_idx);
        end
    end
end

