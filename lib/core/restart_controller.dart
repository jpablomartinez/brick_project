import 'package:brick_project/core/constants.dart';

class RestartController {
  double restartTime = 0;

  bool isDurationComplete() {
    return restartTime > 60;
  }

  void resetRestartTime() {
    restartTime = 0;
  }

  void fullBoard(List<List<int>> board, int localRow) {
    for (int i = localRow - 1; i > localRow - 2; i--) {
      for (int j = 0; j < colums; j++) {
        board[i][j] = 1;
      }
    }
  }

  void cleanBoard(List<List<int>> board, int localRow) {
    for (int i = localRow * -1; i < (localRow * -1) + 1 && (localRow * -1) < row; i++) {
      for (int j = 0; j < colums; j++) {
        board[i][j] = 0;
      }
    }
  }

  void restartAnimation(List<List<int>> board, int localRow) {
    if (localRow > 0) {
      fullBoard(board, localRow);
    } else {
      cleanBoard(board, localRow);
    }
  }
}
