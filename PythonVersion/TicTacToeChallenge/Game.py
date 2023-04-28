import random
from Board import Board
from Bot import Bot

class Game:
    """
    A base class for representing a generic game with various game modes.
    This class should be subclassed to implement specific game rules and logic.
    """

    def __init__(self, name, num_players):
        """
        Initialize the game with the given name and number of players.
        """
        self.name = name
        self.num_players = num_players
        self.board = None

    def display_game_info(self):
        """
        Display the game information, including name and number of players.
        """
        print(f"Game Name: {self.name}")
        print(f"Number of Players: {self.num_players}")

    def start(self):
        """
        Initialize the game state. This method should be implemented in derived classes.
        """
        raise NotImplementedError("This method should be implemented in the derived class.")

    def end(self):
        """
        Determine if the game has ended. This method should be implemented in derived classes.
        """
        raise NotImplementedError("This method should be implemented in the derived class.")

    def make_move(self, player, position):
        """
        Perform a move for the given player at the given position.
        This method should be implemented in derived classes.
        """
        raise NotImplementedError("This method should be implemented in the derived class.")

    def generate_random_move(self):
        """
        Generate a random valid move for the computer player.
        This method should be implemented in derived classes.
        """
        raise NotImplementedError("This method should be implemented in the derived class.")

    def play_human_vs_human(self):
        """
        Play a game in Human vs Human mode, where both players provide input for their moves.
        """
        print("Human vs Human mode")
        self.start()
        while not self.end():
            for player in range(self.num_players):
                position = input(f"Player {player + 1}, enter your move: ")
                self.make_move(player, position)
        print("Game Over")

    def play_human_vs_computer(self, bot):
        """
        Play a game in Human vs Computer mode, where the human player provides input for their moves,
        and the computer player uses a bot for its moves.
        """
        print("Human vs Computer mode")
        self.start()
        while not self.end():
            for player in range(self.num_players):
                if player == 0:
                    position = input(f"Player {player + 1} (Human), enter your move: ")
                    position = eval(position)
                else:
                    position = bot.make_move(self.board)
                    print(f"Player {player + 1} (Computer) made a move: {position}")
                self.make_move(player, position)
        print("Game Over")

    def play_computer_vs_computer(self, bot1, bot2):
        """
        Play a game in Computer vs Computer mode, where both computer players use bots for their moves.
        """
        print("Computer vs Computer mode")
        self.start()
        while not self.end():
            for player in range(self.num_players):
                bot = bot1 if player == 0 else bot2
                position = bot.make_move(self.board)
                print(f"Player {player + 1} (Computer) made a move: {position}")
                self.make_move(player, position)
        print("Game Over")
