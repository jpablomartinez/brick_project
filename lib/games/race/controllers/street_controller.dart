import 'package:brick_project/core/game_board.dart';

class StreetController {
  late GameBoard gameBoard;

  StreetController(GameBoard gb) {
    gameBoard = gb;
  }

  void create() {
    int fillValue = 0;
    int current = 0;
    for (int i = 0; i < 20; i++) {
      if ((fillValue == 0 && current == 2) || (fillValue == 1 && current == 3)) {
        fillValue = 1 - fillValue;
        current = 0;
      }
      gameBoard.board[i][0] = fillValue;
      gameBoard.board[i][9] = fillValue;
      current++;
    }
  }

  void update() {
    int firstColumnLastElement = gameBoard.board[19][0];
    int lastColumnLastElement = gameBoard.board[19][9];

    for (int row = 19; row > 0; row--) {
      gameBoard.board[row][0] = gameBoard.board[row - 1][0];
      gameBoard.board[row][9] = gameBoard.board[row - 1][9];
    }

    gameBoard.board[0][0] = firstColumnLastElement;
    gameBoard.board[0][9] = lastColumnLastElement;
  }
}
