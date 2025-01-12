import 'package:brick_project/core/constants.dart';
import 'package:brick_project/core/game_board.dart';

class Car {
  List<int> body = [1, 0, 1, 19, 0, 1, 0, 18, 1, 1, 1, 17, 0, 1, 0, 16];

  late bool leftLane;
  late GameBoard gameBoard;

  Car(GameBoard board) {
    leftLane = true;
    gameBoard = board;
  }

  void clear() {
    int column = leftLane ? left : right;
    for (int i = 1; i < body.length; i += 4) {
      int pos = body[i + 2];
      gameBoard.board[pos][column - 1] = 0;
      gameBoard.board[pos][column] = 0;
      gameBoard.board[pos][column + 1] = 0;
    }
  }

  void move(int column) {
    for (int i = 1; i < body.length; i += 4) {
      int pos = body[i + 2];
      gameBoard.board[pos][column - 1] += body[i - 1];
      gameBoard.board[pos][column] += body[i];
      gameBoard.board[pos][column + 1] += body[i + 1];
    }
  }

  void moveToRight() {
    if (leftLane) {
      clear();
      move(right);
      leftLane = false;
    }
  }

  void moveToLeft() {
    if (!leftLane) {
      clear();
      move(left);
      leftLane = true;
    }
  }
}
