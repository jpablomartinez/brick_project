import 'package:brick_project/core/game_board.dart';

class NpcCar {
  int column = 0;
  late bool ready;
  late GameBoard gameBoard;
  late bool isInLeftPosition;

  List<int> body = [1, 0, 1, 0, 0, 1, 0, -1, 1, 1, 1, -2, 0, 1, 0, -3];

  NpcCar(int value, GameBoard board, {bool r = true}) {
    column = getStartPosition(value);
    gameBoard = board;
    ready = r;
  }

  static int getStartPosition(int value) {
    return value <= 4 ? 3 : 6;
  }

  void start(int random) {
    ready = true;
    column = getStartPosition(random);
  }

  void restart() {
    body = [1, 0, 1, 0, 0, 1, 0, -1, 1, 1, 1, -2, 0, 1, 0, -3];
  }

  void isCarOut() {
    if (ready) {
      if (body[3] == 20 && body[7] == 20 && body[11] == 20 && body[15] == 20) {
        ready = false;
        restart();
      }
    }
  }

  void clear() {
    for (int i = 1; i < body.length; i += 4) {
      if (body[i + 2] > 0) {
        int pos = body[i + 2];
        gameBoard.board[pos - 1][column - 1] = 0;
        gameBoard.board[pos - 1][column] = 0;
        gameBoard.board[pos - 1][column + 1] = 0;
      }
    }
    isCarOut();
  }

  void move() {
    if (ready) {
      for (int i = 1; i < body.length; i += 4) {
        int pos = body[i + 2];
        if (pos >= 0 && pos < 20) {
          gameBoard.board[pos][column - 1] += body[i - 1];
          gameBoard.board[pos][column] += body[i];
          gameBoard.board[pos][column + 1] += body[i + 1];
        }
        if (body[i + 2] < 20) {
          body[i + 2] = body[i + 2] + 1;
        }
      }
    }
  }

  @override
  String toString() {
    return 'ready: $ready / column: $column';
  }
}
