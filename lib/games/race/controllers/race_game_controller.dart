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
  double updateTime = 0;
  var gameState = GameStates.start;
  late GameBoard gameBoard;
  late StreetController streetController;
  late Timer frameTimer;
  late Timer gameTimer;
  late Function updateView;

  @override
  void startGame(Function updateV) {
    gameBoard = GameBoard();
    streetController = StreetController(gameBoard);
    streetController.create();
    updateView = updateV;
    //TODO: DEFINE TIME TO START
    gameState = GameStates.play;
    gameTimer = Timer.periodic(const Duration(milliseconds: 100), getElapsedTime);
    update();
  }

  @override
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (1000 / 60).floor()), (timer) {
      print('frame runnig');
      builder(timer);
    });
  }

  void getElapsedTime(Timer timer) {
    updateTime += 0.1;
    print('time: ${updateTime}');
  }

  void updateFrame() {
    print('updating...');
    updateView();
  }

  void builder(Timer timer) {
    print('state; ${gameState}');
    if (gameState == GameStates.play) {
      if (updateTime >= 0.4) {
        streetController.update();
        //gameBoard.printBoard();
        updateFrame();
        updateTime = 0;
        print("aaa");
      }
    }
  }
}
