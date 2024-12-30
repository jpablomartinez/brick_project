import 'dart:async';

import 'package:brick_project/core/constants.dart';
import 'package:brick_project/core/game_board.dart';
import 'package:brick_project/core/i_game.dart';
import 'package:brick_project/games/race/controllers/street_controller.dart';

class RaceGameController extends IGame {
  int level = 1;
  int speed = 1;
  int points = 0;
  int lives = 4;
  int updateTime = 0;
  var gameState = GameStates.start;
  late GameBoard gameBoard;
  late StreetController streetController;
  late Timer frameTimer;
  late Timer gameTimer;
  late Function updateView;

  @override
  void startGame() {
    gameBoard = GameBoard();
    streetController = StreetController(gameBoard);
    streetController.create();
    //updateView = update;
    //TODO: DEFINE TIME TO START
    gameState = GameStates.play;
    gameTimer = Timer.periodic(const Duration(milliseconds: 100), getElapsedTime);
    update();
  }

  @override
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (fps * 1000).floor()), builder);
  }

  void getElapsedTime(Timer timer) {
    updateTime++;
  }

  void builder(Timer timer) {
    if (gameState == GameStates.play) {
      if (updateTime > 0.7) {
        streetController.update();
        //gameBoard.printBoard();
        //updateView();
        updateTime = 0;
      }
    }
  }
}
