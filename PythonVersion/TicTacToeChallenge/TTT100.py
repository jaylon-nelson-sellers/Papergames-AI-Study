from TicTacToeBot import TicTacToeBot
from DNA import DNA
from SingleLayerPerceptron import SingleLayerPerceptron


class TTT100(TicTacToeBot):

    def __init__(self):
        DNA = self.createDNA()
        super().__init__(DNA)

    def createDNA(self):
        SLP = SingleLayerPerceptron("softmax", 27, 9)
        D = DNA("Perceptron", SLP)
        return D
