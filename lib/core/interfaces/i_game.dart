import 'dart:async';

abstract class IGame {
  double fps = 1 / 60;

  void startGame(Function frameUpdate);
  void builder(Timer timer);
  void update();
  void restart();
  void updatePoints();
  void updateLevel();
  bool checkGameOver();
  void checkWin();
  void pause();
  void play();
}
