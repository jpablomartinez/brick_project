import 'package:brick_project/utils/constants.dart';

class RestartController {
  double restartTime = 0;

  bool isDurationComplete() {
    return restartTime > 60;
  }

  void resetRestartTime() {
    restartTime = 0;
  }

  /// Fills a specific row of the board with 1s.
  ///
  /// This method modifies the given `board` by setting all elements
  /// in the row specified by `localRow - 1` to 1. It iterates over
  /// each column in the specified row and updates the value.
  ///
  /// Parameters:
  /// - `board`: A 2D list representing the board to be modified.
  /// - `localRow`: The row index used to determine which row to fill.
  void fullBoard(List<List<int>> board, int localRow) {
    for (int i = localRow - 1; i > localRow - 2; i--) {
      for (int j = 0; j < colums; j++) {
        board[i][j] = 1;
      }
    }
  }

  /// Clears a specific row of the board by setting its elements to 0.
  ///
  /// This method modifies the given `board` by setting all elements
  /// in the row specified by `localRow * -1` to 0. It iterates over
  /// each column in the specified row and updates the value.
  ///
  /// Parameters:
  /// - `board`: A 2D list representing the board to be modified.
  /// - `localRow`: The row index used to determine which row to clear.
  void cleanBoard(List<List<int>> board, int localRow) {
    for (int i = localRow * -1; i < (localRow * -1) + 1 && (localRow * -1) < row; i++) {
      for (int j = 0; j < colums; j++) {
        board[i][j] = 0;
      }
    }
  }

  /// Modifies a specific row of the board based on the value of `localRow`.
  ///
  /// If `localRow` is positive, the method fills the specified row with 1s
  /// using the `fullBoard` method. If `localRow` is non-positive, it clears
  /// the row by setting its elements to 0 using the `cleanBoard` method.
  ///
  /// Parameters:
  /// - `board`: A 2D list representing the board to be modified.
  /// - `localRow`: The row index used to determine which row to modify.
  void restartAnimation(List<List<int>> board, int localRow) {
    if (localRow > 0) {
      fullBoard(board, localRow);
    } else {
      cleanBoard(board, localRow);
    }
  }
}
