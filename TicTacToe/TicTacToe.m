classdef TicTacToe
    %TICTACTOE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        board
    end

    methods
        function obj = TicTacToe()
            obj.board = zeros(3, 3);
        end

        function obj = playHumanBotGame(obj, Bot)
            % Loop until the game is over
            while true
                disp( obj.board);

                % Check if the move is valid
                while true
                    row = input('Enter row: ');
                    if (row == -1)
                        return;
                    end
                    col = input('Enter column: ');
                    if (row == -1)
                        return;
                    end
                    if (row > 3 || row < -1 || col > 3 || col < -1)
                        fprintf('Invalid. Try again.\n');
                    elseif obj.board(row, col) == 0
                        obj.board(row, col) = 1;
                        break;
                    else
                        fprintf('That spot is already taken. Try again.\n');
                    end
                end

                % Update the board
                obj.board(row, col) = 1;
                disp( obj.board);

                % Check if the player has won
                if check_win(obj.board, 1)
                    fprintf('You win!\n');
                    break;
                end

                % Check if the game is a tie
                if check_tie(obj.board)
                    fprintf('The game is a tie.\n');
                    break;
                end

                % Get the bot's move
                fprintf('The bot is making a move...\n');
                [row, col] = Bot.bot_move(obj.board);
                obj.board(row, col) = 2;
                disp( obj.board);
                % Check if the bot has won
                if check_win(obj.board, 2)
                    fprintf('The bot wins!\n');
                    break;
                end

                % Check if the game is a tie
                if check_tie(obj.board)
                    fprintf('The game is a tie.\n');
                    break;
                end
            end

        end

        function winner = playBotBotGame(obj, Bot, Bot2)
            % Loop until the game is over
            while true

                fprintf('The bot is making a move...\n');
                [row, col] = Bot.bot_move(obj.board,1);
                obj.board(row, col) = 1;
                disp( obj.board);
                % Check if the bot has won
                if check_win(obj.board, 1)
                    fprintf('Bot 1 wins!\n');
                    winner = 1;
                    break;
                end

                % Check if the game is a tie
                if check_tie(obj.board)
                    fprintf('The game is a tie.\n');
                    winner = 0;
                    break;
                end

                % Get the bot's move
                fprintf('The bot is making a move...\n');
                [row, col] = Bot.bot_move(obj.board,2);
                obj.board(row, col) = 2;
                disp( obj.board);
                % Check if the bot has won
                if check_win(obj.board, 2)
                    winner = 2;
                    fprintf('Bot 2 wins!\n');
                    break;
                end

                % Check if the game is a tie
                if check_tie(obj.board)
                    winner = 0;
                    fprintf('The game is a tie.\n');
                    break;
                end
            end

        end

    end
end

