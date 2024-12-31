import 'package:brick_project/core/game_board.dart';

class Car {
  late bool isInLeftPosition;
  late GameBoard gameBoard;

  Car(bool left, GameBoard board) {
    isInLeftPosition = left;
    gameBoard = board;
    changePosition(0, 1);
  }

  void changePosition(int factor, int value) {
    gameBoard.board[16][3 + factor] = value;
    gameBoard.board[17][3 + factor] = value;
    gameBoard.board[18][3 + factor] = value;
    gameBoard.board[17][2 + factor] = value;
    gameBoard.board[17][4 + factor] = value;
    gameBoard.board[19][2 + factor] = value;
    gameBoard.board[19][4 + factor] = value;
  }

  void moveToRight() {
    if (isInLeftPosition) {
      isInLeftPosition = false;
      changePosition(0, 0);
      changePosition(3, 1);
    }
  }

  void moveToLeft() {
    if (!isInLeftPosition) {
      isInLeftPosition = true;
      changePosition(3, 0);
      changePosition(0, 1);
    }
  }
}
