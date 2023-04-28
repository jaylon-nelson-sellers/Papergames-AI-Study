from Bot import Bot

class TicTacToeBot(Bot):
    def __init__(self, DNA):
        super().__init__(DNA)

    def convert_board_to_input(self, board):
        """
        Convert the game board into a format that can be used as input for the bot.

        Args:
            board: A board object representing the game state.

        Returns:
            input_data: A representation of the board in the desired input format.
        """
        # Flatten the board and convert it to a one-hot encoded representation
        input_data = []
        for row in board:
            for cell in row:
                if cell == 'X':
                    input_data.extend([1, 0, 0])
                elif cell == 'O':
                    input_data.extend([0, 1, 0])
                else:
                    input_data.extend([0, 0, 1])
        return input_data

    def make_move(self, board):
        """
        Make a move on the given game board based on the bot's decision-making process.

        Args:
            board: A board object representing the game state.

        Returns:
            move: A move object representing the bot's chosen move.
        """
        input_data = self.convert_board_to_input(board.board)
        outputs = self.DNA.forward(input_data)
        move_index = self.DNA.output_to_move(outputs)

        # Convert the move index to row and column coordinates
        row = move_index // 3
        col = move_index % 3

        return row, col

    def random_move(self, board):
        """
        Make a random move on the given game board.

        Args:
            board: A board object representing the game state.

        Returns:
            move: A move object representing a randomly chosen move.
        """
        available_moves = [(i, j) for i in range(3) for j in range(3) if board[i][j] == ' ']
        return random.choice(available_moves)

    def update(self, result):
        """
        Update the bot's internal state, rating, and statistics based on the outcome of a game.

        Args:
            result: A game result object representing the outcome of the game.
        """
        self.stats.update(result)
        self.rating.update(result)

    def __str__(self):
        """
        Create a string representation of the bot, including its taxonomy, rating, and stats.

        Returns:
            str: A string representation of the bot.
        """
        return f"Taxonomy: {self.taxonomy}\nRating: {self.rating}\nStats: {self.stats}"
