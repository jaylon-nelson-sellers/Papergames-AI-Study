
S = Season(1024, 1, 100000);
final = S.RunGenerations();

TTT = TicTacToe();
load("best.mat","obj");
bot = obj.BotArray(1);
TTT.playHumanBotGame(bot)