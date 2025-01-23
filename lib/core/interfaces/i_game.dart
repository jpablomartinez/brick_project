import 'dart:async';

import 'package:brick_project/core/game_board.dart';
import 'package:brick_project/utils/constants.dart';

abstract class IGame {
  GameBoard getGameBoard();
  int getLives();
  int getPoints();
  int getSpeed();
  int getLevel();
  GameStates getGameStates();
  bool checkGameOver();
  bool getResetGame();
  void setGameBoard(GameBoard board);
  void setLives(int value);
  void setPoints(int value);
  void setSpeed(int value);
  void setLevel(int value);
  void setGameStates(GameStates state);
  void startGame(Function frameUpdate);
  void builder(Timer timer);
  void update();
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
