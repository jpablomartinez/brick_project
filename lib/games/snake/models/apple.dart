import 'dart:math' as math;
import 'package:brick_project/utils/constants.dart' as constants;
import 'package:brick_project/core/game_board.dart';

class Apple {
  int row;
  int column;
  late GameBoard gameBoard;
  bool hide = true;

  Apple(
    this.row,
    this.column,
    this.gameBoard,
  ) {
    putAppleInBoard();
  }

  void putAppleInBoard() {
    gameBoard.board[row][column] = 1;
    hide = false;
  }

  void changePosition(int r, int c) {
    row = r;
    column = c;
  }

  void hideApple() {
    hide = true;
    gameBoard.board[row][column] = 0;
  }

  void getNewPosition() {
    //get random row
    //get empty column
    int r = math.Random().nextInt(constants.row);
    List<int> candidates = [];
    for (int i = 0; i < gameBoard.board[r].length; i++) {
      if (gameBoard.board[r][i] == 0) {
        candidates.add(i);
      }
    }
    int index = math.Random().nextInt(candidates.length);
    changePosition(r, candidates[index]);
    //putAppleInBoard(r, candidates[index]);
  }
}
