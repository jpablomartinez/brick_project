import 'package:brick_project/utils/colors.dart';
import 'package:flutter/material.dart';

class GameBoardCell extends CustomPainter {
  final List<List<int>> gameBoard;

  GameBoardCell(this.gameBoard);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final cellWidth = size.width / gameBoard[0].length;
    final cellHeight = size.height / gameBoard.length;

    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] == 1) {
          paint.color = BrickProjectColors.black;
        } else {
          paint.color = BrickProjectColors.background;
        }
        canvas.drawRect(
          Rect.fromLTWH(j * cellWidth, i * cellHeight, cellWidth, cellHeight),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
