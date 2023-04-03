classdef Season
    %SEASON Summary of this class goes here
    %   Detailed explanation goes here

    properties
        NumOfBots
        BotArray
        BestBots
        mutateRate
        numOfGenerations
    end

    methods
        function obj = Season(numOfBots, mutateRate, numOfGenerations)
            obj.NumOfBots = numOfBots;
            obj.BotArray = TicTacToeBot.empty(numOfBots, 0);
            obj.BestBots = TicTacToeBot.empty(numOfBots, 0);
            for i = 1:numOfBots
                obj.BotArray(i) = TicTacToeBot();
            end
            obj.mutateRate = mutateRate;
            obj.numOfGenerations = numOfGenerations;
        end

        function obj = RunSeason(obj)
            rounds = round(log2(length(obj.BotArray))); %magic num
            ST = Swiss(obj.BotArray, rounds);

            obj.BotArray = ST.runSeason();
        end

        function obj = RunTournament(obj)
            rounds = round(log2(length(obj.BestBots))); %magic num
            if rounds < 10
                rounds = 10;
            end
            ST = Swiss(obj.BestBots, rounds);

            obj.BestBots = ST.runTournament();
        end

        function obj = breedBest(obj)
            len = length(obj.BotArray);
            rand_order = randperm(len);
            factor = round((obj.NumOfBots/len),1);
            for i = 1:len
                j = rand_order(i);

                newBots = breed(obj.BotArray(j), factor, obj.mutateRate);
                obj.BotArray = [obj.BotArray newBots];
            end
        end

        function obj = RunGenerations(obj)
            for i = 1:obj.numOfGenerations
                if (mod(i, 100000) == 0)
                    obj.mutateRate = obj.mutateRate * .1;
                end
                obj = obj.RunSeason();
                disp("----------------------------------------");
                disp("Generation:" + i);
                tempBots = obj.BotArray;
                
                obj.BestBots = [obj.BestBots tempBots];
                if (mod(i,100) == 0)
                    obj = obj.RunTournament();
                    obj.dispBest(obj.BestBots);
                  
                    numOfBots = round(length(obj.BestBots) * .1);
                    tempBots = TicTacToeBot.empty(numOfBots,0);
                    for x = 1:numOfBots 
                        tempBots(x) = obj.BestBots(x);
                    end
                    obj.BotArray = [obj.BotArray tempBots];
                    fileName = "results/G" + i+ ".mat";
                    save(fileName, "obj");
                end
               
                obj = obj.breedBest();
            end
        end

        function obj = dispBest(obj, Bots)
            for i = 1:500
                BotProfile = Bots(i).Genus + " " + Bots(i).Species;
                disp(i + ") " + BotProfile);
                BotProfile = "Gen: " + Bots(i).generation + " Elo: " + round(Bots(i).rating.rating);
                disp(BotProfile);
                BotStats = "W: " + Bots(i).wins + " | D: " + Bots(i).draws;
                BotStats = BotStats + " | L: " + Bots(i).loses;
                BotStats = BotStats + " | WR: " + Bots(i).winrate;
                disp("Stats: " + BotStats);
                disp(" ");
            end
            disp("----------------------------------------");
        end

    end
end

