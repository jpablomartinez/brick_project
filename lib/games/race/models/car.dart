import 'package:brick_project/core/constants.dart';
import 'package:brick_project/core/game_board.dart';

class Car {
  List<int> body = [1, 0, 1, 19, 0, 1, 0, 18, 1, 1, 1, 17, 0, 1, 0, 16];

  List<List<int>> firstExplosion = <List<int>>[
    <int>[1, 1, 1, 1, 1],
    <int>[1, 0, 0, 0, 1],
    <int>[1, 0, 0, 0, 1],
    <int>[1, 0, 0, 0, 1],
    <int>[1, 1, 1, 1, 1],
  ];
  List<List<int>> secondExplosion = <List<int>>[
    <int>[1, 0, 1, 0, 1],
    <int>[0, 0, 0, 0, 0],
    <int>[1, 0, 0, 0, 1],
    <int>[0, 0, 0, 0, 0],
    <int>[1, 0, 1, 0, 1],
  ];
  List<List<int>> thirdExplosion = <List<int>>[
    <int>[1, 0, 1, 0, 1],
    <int>[0, 1, 1, 1, 0],
    <int>[1, 1, 0, 1, 1],
    <int>[0, 1, 1, 1, 0],
    <int>[1, 0, 1, 0, 1],
  ];
  List<List<int>> fourthExplosion = <List<int>>[
    <int>[0, 0, 0, 0, 0],
    <int>[0, 1, 1, 1, 0],
    <int>[0, 1, 0, 1, 0],
    <int>[0, 1, 1, 1, 0],
    <int>[0, 0, 0, 0, 0],
  ];
  List<List<int>> fifthExplosion = <List<int>>[
    <int>[0, 0, 0, 0, 0],
    <int>[0, 0, 0, 0, 0],
    <int>[0, 0, 1, 0, 0],
    <int>[0, 0, 0, 0, 0],
    <int>[0, 0, 0, 0, 0],
  ];

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
