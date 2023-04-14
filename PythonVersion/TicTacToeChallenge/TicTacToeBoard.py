from Board import Board
class TicTacToeBoard(Board):
    def __init__(self):
        """
        Initialize a 3x3 Tic Tac Toe board.
        """
        super().__init__()
        self.board = [[' ' for _ in range(3)] for _ in range(3)]

    def make_move(self, player, position):
        """
        Perform a move for the given player at the given position, if the move is valid.

        Args:
            player: A string ('X' or 'O') representing the player making the move.
            position: A tuple (row, col) representing the position of the move.

        Returns:
            bool: True if the move is performed, False otherwise.
        """
        if self.is_valid_move(player, position):
            row, col = position
            self.board[row][col] = player
            return True
        return False

    def is_valid_move(self, player, position):
        """
        Check if a move is valid for the given player at the given position.

        Args:
            player: A string ('X' or 'O') representing the player making the move.
            position: A tuple (row, col) representing the position of the move.

        Returns:
            bool: True if the move is valid, False otherwise.
        """
        row, col = position
        if 0 <= row < 3 and 0 <= col < 3:
            return self.board[row][col] == ' '
        return False

    def has_won(self, player):
        """
        Check if the given player has won the game.

        Args:
            player: A string ('X' or 'O') representing the player to check for a win.

        Returns:
            bool: True if the player has won, False otherwise.
        """
        # Check rows
        for row in self.board:
            if all(cell == player for cell in row):
                return True

        # Check columns
        for col in range(3):
            if all(self.board[row][col] == player for row in range(3)):
                return True

        # Check diagonals
        if all(self.board[i][i] == player for i in range(3)):
            return True

        if all(self.board[i][2 - i] == player for i in range(3)):
            return True

        return False

    def is_draw(self):
        """
        Check if the game has reached a draw state.

        Returns:
            bool: True if the game is a draw, False otherwise.
        """
        return all(cell != ' ' for row in self.board for cell in row)

    def __str__(self):
        """
        Return a string representation of the Tic Tac Toe board.

        Returns:
            str: A string representation of the game board.
        """
        board_str = ""
        for row in self.board:
            board_str += "|".join(row) + "\n"
            board_str += "-" * 5 + "\n"
        return board_str[:-6]  # Remove the last row of dashes
