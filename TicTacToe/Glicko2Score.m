classdef Glicko2Score
    % Glicko2Score - A class to track Glicko-2 scores
    
    properties
        score % The current Glicko-2 score
        RD % The current rating deviation
        volatility % The current volatility
        c % The Glicko-2 constant
    end
    
    methods
        
        function obj = Glicko2Score(score, RD, volatility, c)
            % Constructor - Creates a new Glicko2Score object with the given initial score, rating deviation, volatility, and Glicko-2 constant.
            
            obj.score = score;
            obj.RD = RD;
            obj.volatility = volatility;
            obj.c = c;
        end
        
        function [newScore, newRD, newVolatility] = updateScore(obj, opponents, results)
            % updateScore - Updates the Glicko-2 score based on the given opponents and results.
            % opponents is an N-by-1 vector of Glicko2Score objects representing the opponents in the tournament.
            % results is an N-by-1 vector where element i is the result of the match between the current player and opponent i.
            % A result of 1 indicates a win, 0.5 indicates a draw, and 0 indicates a loss.
            
            % Step 1: Calculate the Glicko-2 rating and RD of each player prior to the tournament.
            priorScores = [obj.score; [opponents.score]];
            priorRDs = [obj.RD; [opponents.RD]];
            priorVolatilities = [obj.volatility; [opponents.volatility]];
            [g2r, g2RD, g2v] = glicko2(priorScores, priorRDs, priorVolatilities, obj.c);
            
            % Step 2: Calculate the expected score of the current player against each opponent.
            nOpponents = length(opponents);
            expectedScores = zeros(nOpponents, 1);
            for i = 1:nOpponents
                expectedScores(i) = glicko2ExpectedScore(obj.score, obj.RD, obj.volatility, opponents(i).score, opponents(i).RD, opponents(i).volatility);
            end
            
            % Step 3: Calculate the actual score of the current player against each opponent.
            actualScores = results;
            
            % Step 4: Calculate the quantity v for the current player.
            v = glicko2V(obj.score, obj.volatility);
            
            % Step 5: Calculate the quantity Delta for the current player.
            Delta = 0;
            for i = 1:nOpponents
                Delta = Delta + v^2 * (actualScores(i) - expectedScores(i)) * glicko2G(opponents(i).RD);
            end
            
            % Step 6: Calculate the new values of the rating, rating deviation, and volatility for the current player.
            newRD = glicko2NewRD(obj.RD, g2RD, Delta, obj.c);
            newVolatility = glicko2NewVolatility(obj.volatility, newRD, g2r, g2RD, Delta, obj.c);
            newScore = obj.score + v^2 * sum(actualScores - expectedScores) / (newRD^2 + glicko2D(newVolatility)^2);
        end
        
    end
end