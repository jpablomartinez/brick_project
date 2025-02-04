import 'dart:math' as math;
import 'package:brick_project/utils/constants.dart' as constants;
import 'package:brick_project/core/game_board.dart';

class Apple {
  int row;
  int column;
  late GameBoard gameBoard;

  Apple(
    this.row,
    this.column,
    this.gameBoard,
  ) {
    putAppleInBoard(row, column);
  }

  void putAppleInBoard(int r, int col) {
    gameBoard.board[r][col] = 1;
  }

  void changePosition(int r, int c) {
    row = r;
    column = c;
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
    putAppleInBoard(r, candidates[index]);
  }
}
