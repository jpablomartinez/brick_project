class StreetController {
  /// Initializes the first and last columns of a 20-row board with alternating
  /// fill values. The fill value alternates between 0 and 1 based on a pattern
  /// where two consecutive rows have the same value followed by three rows with
  /// the opposite value.
  ///
  /// The board parameter is a 2D list where each sublist represents a row.
  /// The method modifies the first and last elements of each row.
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

  /// Updates the first and last columns of a 20-row board by shifting each
  /// element down by one row. The last elements of the first and last columns
  /// are moved to the top of their respective columns.
  ///
  /// The board parameter is a 2D list where each sublist represents a row.
  /// This method modifies the first and last elements of each row.
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
