// ignore_for_file: avoid_print

import 'package:brick_project/core/constants.dart';
import 'package:flutter/material.dart';

class GameBoard {
  List<List<int>> board = [];

  void _buildGameBoard() {
    board = List.generate(row, (_) => List.filled(colums, 0));
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
