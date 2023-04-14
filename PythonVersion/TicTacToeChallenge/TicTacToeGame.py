from Game import Game
from TicTacToeBoard import TicTacToeBoard
class TicTacToeGame(Game):
    def __init__(self):
        super().__init__("Tic Tac Toe", 2)
        self.board = TicTacToeBoard()

    def start(self):
        """
        Initialize the game state. In Tic Tac Toe, no additional setup is required.
        """
        pass

    def end(self):
        """
        Determine if the game has ended, and return the winning player or a draw.

        Returns:
            int: 0 if the game has not ended, 1 if player 1 wins, 2 if player 2 wins, 3 if the game is a draw.
        """
        if self.board.has_won("X"):
            return 1
        elif self.board.has_won("O"):
            return 2
        elif self.board.is_draw():
            return 3
        else:
            return 0

    def move(self, player, position):
        """
        Perform a move for the given player at the given position.

        Args:
            player: An integer (0 or 1) representing the player making the move.
            position: A string in the format "row,col" representing the position of the move.
        """
        player_symbol = "X" if player == 0 else "O"
        row, col = map(int, position.split(","))
        if self.board.is_valid_move(player_symbol, (row, col)):
            self.board.make_move(player_symbol, (row, col))
            print(self.board)
        else:
            print("Invalid move. Please try again.")

    def generate_computer_move(self):
        """
        Generate a random valid move for the computer player.

        Returns:
            str: A string in the format "row,col" representing the position of the move.
        """
        row, col = random.randint(0, 2), random.randint(0, 2)
        while not self.board.is_valid_move("O", (row, col)):
            row, col = random.randint(0, 2), random.randint(0, 2)
        return f"{row},{col}"
