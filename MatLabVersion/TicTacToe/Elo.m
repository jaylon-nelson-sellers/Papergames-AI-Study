classdef Elo
    properties
        rating % current rating
        k % K-factor
    end
    
    methods
        function obj = Elo(rating, k)
            % Constructor
            obj.rating = rating;
            obj.k = k;
        end
        
        function obj = updateRating(obj,opponent_rating, outcome)
            % Update the rating based on the given outcome and opponent rating
            expected_score = 1/(1 + 10^((opponent_rating- obj.rating)/400));
            new_rating = obj.rating + obj.k*(outcome - expected_score);
            obj.rating = new_rating;
        end
    end
end





