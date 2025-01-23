// ignore_for_file: avoid_print

import 'package:brick_project/utils/constants.dart';
import 'package:flutter/material.dart';

class GameBoard {
  List<List<int>> board = [];

  void _buildGameBoard() {
    board = List.generate(row, (_) => List.filled(colums, 0));
  }

  bool cellIsOne(int row, int col) {
    return board[row][col] == 1;
  }

  void printBoard() {
    for (int i = 0; i < row; i++) {
      debugPrint(" ${board[i].join(' ')} ", wrapWidth: 1024);
    }
    print("//////////////////////////");
  }

  GameBoard() {
    _buildGameBoard();
  }
}
