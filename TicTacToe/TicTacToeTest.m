
S = Season(256, 1, 1000000);
final = S.RunGenerations();

TTT = TicTacToe();
load("best.mat","obj");
bot = obj.BotArray(1);
TTT.playHumanBotGame(bot)