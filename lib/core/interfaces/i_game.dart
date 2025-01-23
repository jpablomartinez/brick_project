abstract class IGame {
  int getLives();
  int getPoints();
  int getSpeed();
  int getLevel();
  bool checkGameOver();
  bool getResetGame();
  void setLives(int value);
  void setPoints(int value);
  void setSpeed(int value);
  void setLevel(int value);
  void startGame();
  void restart();
  void updatePoints();
  void updateLevel();
  void checkWin();
  void pause();
  void play();
  void setAudioSettings();
  void left();
  void right();
  void up();
  void down();
  void rotateButton(bool value);
  void handlePlayState();
  void handleCollisionState();
  void handleStartAnimation();
  void handleGameOver();
  void handleRestartViewState();
  void setResetGame(bool value);
}
