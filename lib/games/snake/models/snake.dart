import 'package:brick_project/core/game_board.dart';
import 'package:brick_project/games/snake/models/apple.dart';
import 'package:brick_project/utils/constants.dart';

enum SnakeDirection {
  left,
  right,
  up,
  down,
}

class SnakeBody {
  int row;
  int column;

  SnakeBody(this.row, this.column);
}

class Snake {
  int eatenApples = 0;
  late List<SnakeBody> body;
  late GameBoard gameBoard;
  late SnakeDirection direction;

  Snake(int r, int c, GameBoard board) {
    body = [];
    body.add(SnakeBody(r, c));
    body.add(SnakeBody(r, c - 1));
    body.add(SnakeBody(r, c - 2));
    gameBoard = board;
    direction = SnakeDirection.right;
    updateBodyInBoard();
  }

  bool isSnakeCollide() {
    int r = body.first.row;
    int c = body.first.column;
    return body.sublist(1).indexWhere((e) => e.column == c && e.row == r) != -1;
  }

  void eat(Apple apple) {
    if (body.first.row == apple.row && body.first.column == apple.column) {
      apple.hideApple();
      apple.getNewPosition();
      int rowLast = body.last.row;
      int colLast = body.last.column;
      body.add(SnakeBody(rowLast, colLast));
      eatenApples++;
    }
  }

  void clear() {
    for (int i = 0; i < body.length; i++) {
      SnakeBody b = body[i];
      gameBoard.board[b.row][b.column] = 0;
    }
  }

  void swapBody() {
    for (int i = body.length - 1; i > 0; i--) {
      body[i].row = body[i - 1].row;
      body[i].column = body[i - 1].column;
    }
  }

  void updateBodyInBoard() {
    for (int i = 0; i < body.length; i++) {
      SnakeBody b = body[i];
      gameBoard.board[b.row][b.column] = 1;
    }
  }

  void move(Apple apple) {
    clear();
    swapBody();
    eat(apple);
    switch (direction) {
      case SnakeDirection.left:
        if (body[0].column - 1 >= 0) {
          body[0].column = body[0].column - 1;
        }
        break;
      case SnakeDirection.right:
        if (body[0].column + 1 < columns) {
          body[0].column = body[0].column + 1;
        }
        break;
      case SnakeDirection.down:
        if (body[0].row + 1 < row) {
          body[0].row = body[0].row + 1;
        }
        break;
      case SnakeDirection.up:
        if (body[0].row - 1 >= 0) {
          body[0].row = body[0].row - 1;
        }
        break;
      default:
        break;
    }
    updateBodyInBoard();
  }

  bool checkCollision() {
    return body.first.column >= columns || body.first.row >= row || isSnakeCollide() || body.first.row <= -1 || body.first.column <= -1;
  }

  void auto() {
    clear();
    swapBody();
    switch (direction) {
      case SnakeDirection.left:
        if (body[0].column - 1 >= 0) {
          body[0].column = body[0].column - 1;
        } else {
          body[0].row = body[0].row - 1;
          direction = SnakeDirection.up;
        }
        break;
      case SnakeDirection.right:
        if (body[0].column + 1 < columns) {
          body[0].column = body[0].column + 1;
        } else {
          body[0].row = body[0].row + 1;
          direction = SnakeDirection.down;
        }
        break;
      case SnakeDirection.down:
        if (body[0].row + 1 < row) {
          body[0].row = body[0].row + 1;
        } else {
          body[0].column = body[0].column - 1;
          direction = SnakeDirection.left;
        }
        break;
      case SnakeDirection.up:
        if (body[0].row - 1 >= 0) {
          body[0].row = body[0].row - 1;
        } else {
          body[0].column = body[0].column + 1;
          direction = SnakeDirection.right;
        }
        break;
      default:
        break;
    }
    updateBodyInBoard();
  }
}
