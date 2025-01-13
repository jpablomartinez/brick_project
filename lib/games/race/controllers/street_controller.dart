class StreetController {
  void create(List<List<int>> board) {
    int fillValue = 0;
    int current = 0;
    for (int i = 0; i < 20; i++) {
      if ((fillValue == 0 && current == 2) || (fillValue == 1 && current == 3)) {
        fillValue = 1 - fillValue;
        current = 0;
      }
      board[i][0] = fillValue;
      board[i][9] = fillValue;
      current++;
    }
  }

  void update(List<List<int>> board) {
    int firstColumnLastElement = board[19][0];
    int lastColumnLastElement = board[19][9];

    for (int row = 19; row > 0; row--) {
      board[row][0] = board[row - 1][0];
      board[row][9] = board[row - 1][9];
    }

    board[0][0] = firstColumnLastElement;
    board[0][9] = lastColumnLastElement;
  }
}
