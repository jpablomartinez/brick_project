import 'dart:math' as math;
import 'package:brick_project/games/snake/models/snake.dart';
import 'package:brick_project/utils/constants.dart' as constants;
import 'package:logger/web.dart';

class Apple {
  int row;
  int column;

  bool hide = true;
  var logger = Logger();

  Apple(
    this.row,
    this.column,
    List<List<int>> board,
  ) {
    putAppleInBoard(board);
  }

  void putAppleInBoard(List<List<int>> board) {
    board[row][column] = 1;
    hide = false;
  }

  void changePosition(int r, int c) {
    row = r;
    column = c;
  }

  void hideApple(List<List<int>> board) {
    hide = true;
    board[row][column] = 0;
  }

  void getNewPosition(List<SnakeBody> body) {
    //get random row
    //get empty column
    int r = math.Random().nextInt(constants.row);
    int c = math.Random().nextInt(constants.columns);
    while (body.indexWhere((b) => b.row == r && b.column == c) != -1) {
      r = math.Random().nextInt(constants.row);
      c = math.Random().nextInt(constants.columns);
    }

    logger.d('[LOG] \n Row: $r Column: $c \n NEW POSITION: ($r,$c})');
    changePosition(r, c);
  }
}
