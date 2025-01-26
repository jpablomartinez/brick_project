import 'package:brick_project/utils/colors.dart';
import 'package:flutter/material.dart';

class CanvasGame extends CustomPainter {
  final List<List<int>> gameBoard;

  CanvasGame(this.gameBoard);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final cellWidth = size.width / gameBoard[0].length;
    final cellHeight = size.height / gameBoard.length;

    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        final x = j * cellWidth;
        final y = i * cellHeight;

        Color black = gameBoard[i][j] == 1 ? BrickProjectColors.black : BrickProjectColors.black.withOpacity(0.04);

        // Outer border
        paint.color = BrickProjectColors.background;
        canvas.drawRect(Rect.fromLTWH(x, y, cellWidth, cellHeight), paint);

        // Inner border 1
        paint.color = black;
        canvas.drawRect(
          Rect.fromLTWH(x + 1.5, y + 1.5, cellWidth - 3, cellHeight - 3),
          paint,
        );

        // Inner layer
        paint.color = BrickProjectColors.background;
        canvas.drawRect(
          Rect.fromLTWH(x + 4.5, y + 4.5, cellWidth - 9, cellHeight - 9),
          paint,
        );

        // Final inner border
        paint.color = black;
        canvas.drawRect(
          Rect.fromLTWH(x + 7.5, y + 7.5, cellWidth - 15, cellHeight - 15),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
