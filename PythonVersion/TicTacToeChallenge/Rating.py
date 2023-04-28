import math

class Glicko2Rating:
    def __init__(self, rating=1500, rating_deviation=350, tau=0.5):
        """
        Initialize a Glicko-2 rating object.

        Args:
            rating (float): The initial rating value (default: 1500).
            rating_deviation (float): The initial rating deviation (default: 350).
            tau (float): The system's rating volatility parameter (default: 0.5).
        """
        self.rating = rating
        self.rating_deviation = rating_deviation
        self.tau = tau
        self.volatility = 0.06

    def g_function(self, opponent_rd):
        """
        Compute the Glicko-2 'g' function.

        Args:
            opponent_rd (float): The opponent's rating deviation.

        Returns:
            float: The 'g' function value.
        """
        return 1 / math.sqrt(1 + (3 * (opponent_rd ** 2)) / (math.pi ** 2))

    def E_function(self, opponent_rating, opponent_rd):
        """
        Compute the Glicko-2 'E' function.

        Args:
            opponent_rating (float): The opponent's rating.
            opponent_rd (float): The opponent's rating deviation.

        Returns:
            float: The 'E' function value.
        """
        return 1 / (1 + math.exp(-self.g_function(opponent_rd) * (self.rating - opponent_rating)))

    def update_rating(self, opponent_rating, opponent_rd, outcome):
        """
        Update the rating based on a game result.

        Args:
            opponent_rating (float): The opponent's rating.
            opponent_rd (float): The opponent's rating deviation.
            outcome (float): The game outcome (1 for a win, 0.5 for a draw, 0 for a loss).
        """
        # Calculate the g function for the opponent
        g_opponent = self.g_function(opponent_rd)

        # Calculate the E function for the opponent
        E_opponent = self.E_function(opponent_rating, opponent_rd)

        # Compute v (the estimated variance of the player's rating)
        v_inverse = g_opponent ** 2 * E_opponent * (1 - E_opponent)
        v = 1 / v_inverse

        # Compute delta (the estimated improvement in rating)
        delta = v * g_opponent * (outcome - E_opponent)

        # Update the player's rating volatility (sigma) using the iterative algorithm
        # ... (the rest of the update_rating method remains unchanged)

        self.rating = new_rating
        self.rating_deviation = new_rd
        self.volatility = new_volatility
