class Stats:
    def __init__(self):
        """
        Constructor that initializes the variables to 0.
        """
        self.games = 0
        self.wins = 0
        self.loses = 0
        self.draws = 0
        self.winrate = 0
        self.tournaments_won = 0

    def update(self, result):
        """
        Update function that takes in a double input called "result" to update the stats.

        Args:
            result (float): The game result (1 for a win, 0.5 for a draw, 0 for a loss).
        """
        # Always increase the games count by 1
        self.games += 1

        # Update wins, draws, and losses based on the result value
        if result == 1:
            self.wins += 1
        elif result == 0.5:
            self.draws += 1
        elif result == 0:
            self.loses += 1

        # Update the winrate
        self.winrate = ((self.wins + self.draws) / self.games) * 100

    def increase_tournament_wins(self):
        """
        Increase the count of tournaments won by 1.
        """
        self.tournaments_won += 1

    def __str__(self):
        """
        Create a string representation of the stats, including all the variables neatly formatted.

        Returns:
            str: A string representation of the stats.
        """
        stats_str = (
            f"Games: {self.games}\n"
            f"Wins: {self.wins}\n"
            f"Loses: {self.loses}\n"
            f"Draws: {self.draws}\n"
            f"Winrate: {self.winrate:.2f}%\n"
            f"Tournaments Won: {self.tournaments_won}"
        )
        return stats_str
