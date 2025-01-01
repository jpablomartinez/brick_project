import 'package:brick_project/core/game_board.dart';

class NpcCar {
  int column = 0;
  late bool ready;
  late GameBoard gameBoard;
  late bool isInLeftPosition;

  List<int> positions = [1, 0, 1, 0, 0, 1, 0, -1, 1, 1, 1, -2, 0, 1, 0, -3];

  NpcCar(int value, GameBoard board, {bool r = true}) {
    column = value <= 4 ? 3 : 6;
    gameBoard = board;
    ready = r;
  }

  void restart() {
    positions = [1, 0, 1, 0, 0, 1, 0, -1, 1, 1, 1, -2, 0, 1, 0, -3];
  }

  void isCarOut() {
    if (ready) {
      if (positions[3] == 20 && positions[7] == 20 && positions[11] == 20 && positions[15] == 20) {
        ready = false;
        restart();
      }
    }
  }

  void clear() {
    for (int i = 1; i < positions.length; i += 4) {
      if (positions[i + 2] > 0) {
        int pos = positions[i + 2];
        gameBoard.board[pos - 1][column - 1] = 0;
        gameBoard.board[pos - 1][column] = 0;
        gameBoard.board[pos - 1][column + 1] = 0;
      }
    }
    isCarOut();
  }

  void move() {
    for (int i = 1; i < positions.length; i += 4) {
      int pos = positions[i + 2];
      if (pos >= 0 && pos < 20) {
        gameBoard.board[pos][column - 1] = positions[i - 1];
        gameBoard.board[pos][column] = positions[i];
        gameBoard.board[pos][column + 1] = positions[i + 1];
      }
      if (positions[i + 2] < 20) {
        positions[i + 2] = positions[i + 2] + 1;
      }
    }
  }
}
