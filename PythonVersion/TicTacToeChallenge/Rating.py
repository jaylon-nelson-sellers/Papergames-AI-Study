import math


class Rating:
    def __init__(self, rating=1500, rd=350, tau=0.5):
        """
        Initialize a Glicko-2 rating object.

        Args:
            rating (float): The initial rating value (default: 1500).
            rd (float): The initial rating deviation (default: 350).
            tau (float): The system's rating volatility parameter (default: 0.5).
        """
        self.rating = rating
        self.rd = rd
        self.tau = tau
        self.volatility = 0.06

    def g(self, opp_rd):
        """
        Compute the Glicko-2 'g' function.

        Args:
            opp_rd (float): The opponent's rating deviation.

        Returns:
            float: The 'g' function value.
        """
        return 1 / math.sqrt(1 + (3 * (opp_rd ** 2)) / (math.pi ** 2))

    def E(self, opp_rating, opp_rd):
        """
        Compute the Glicko-2 'E' function.

        Args:
            opp_rating (float): The opponent's rating.
            opp_rd (float): The opponent's rating deviation.

        Returns:
            float: The 'E' function value.
        """
        return 1 / (1 + math.exp(-self.g(opp_rd) * (self.rating - opp_rating)))

    def update(self, opp_rating, opp_rd, outcome):
        """
        Update the rating based on a game result.

        Args:
            opp_rating (float): The opponent's rating.
            opp_rd (float): The opponent's rating deviation.
            outcome (float): The game outcome (1 for a win, 0.5 for a draw, 0 for a loss).
        """
        # Calculate the g function for the opponent
        g_opp = self.g(opp_rd)

        # Calculate the E function for the opponent
        E_opp = self.E(opp_rating, opp_rd)

        # Compute v (the estimated variance of the player's rating)
        v_inv = g_opp ** 2 * E_opp * (1 - E_opp)
        v = 1 / v_inv

        # Compute delta (the estimated improvement in rating)
        delta = v * g_opp * (outcome - E_opp)

        # Update the player's rating volatility (sigma) using the iterative algorithm
        A = math.log(self.volatility ** 2)
        epsilon = 0.000001

        def f(x):
            e_x = math.exp(x)
            return e_x * (delta ** 2 - self.rd ** 2 - v - e_x) / (2 * (self.rd ** 2 + v + e_x) ** 2) - (x - A) / (
                        self.tau ** 2)

        a = A
        B = None
        if delta ** 2 > self.rd ** 2 + v:
            B = math.log(delta ** 2 - self.rd ** 2 - v)
        else:
            k = 1
            while f(A - k * self.tau) < 0:
                k += 1
            B = A - k * self.tau

        f_a = f(a)
        f_b = f(B)

        while abs(B - a) > epsilon:
            C = a + (a - B) * f_a / (f_b - f_a)
            f_c = f(C)

            if f_c * f_b < 0:
                a = B
                f_a = f_b
            else:
                f_a /= 2
            B = C
            f_b = f_c

        new_volatility = math.exp(B / 2)

        # Update the player's rating and rating deviation
        new_rd = math.sqrt(self.rd ** 2 + new_volatility ** 2)
        new_rating = self.rating + g_opp * new_rd * (outcome - E_opp)

        self.rating = new_rating
        self.rd = new_rd
        self.volatility = new_volatility

