import 'dart:async';
import 'dart:math' as math;
import 'package:brick_project/core/constants.dart';
import 'package:brick_project/core/game_board.dart';
import 'package:brick_project/core/i_game.dart';
import 'package:brick_project/games/race/controllers/street_controller.dart';
import 'package:brick_project/games/race/models/car.dart';
import 'package:brick_project/games/race/models/npc_car.dart';

class RaceGameController extends IGame {
  int level = 1;
  int speed = 1;
  int points = 0;
  int lives = 4;
  double updateTime = 0;
  double waitTime = 0;
  var gameState = GameStates.start;
  late GameBoard gameBoard;
  late StreetController streetController;
  late Timer frameTimer;
  late Timer gameTimer;
  late Function updateView;
  late Car player;
  late List<NpcCar> cars;

  @override
  void startGame(Function frameUpdate) {
    gameBoard = GameBoard();
    streetController = StreetController(gameBoard);
    streetController.create();
    updateView = frameUpdate;
    player = Car(true, gameBoard);
    int first = math.Random().nextInt(10); // Value is >= 0 and < 10.
    int second = math.Random().nextInt(10); // Value is >= 0 and < 10.
    cars = [NpcCar(first, gameBoard), NpcCar(second, gameBoard, r: false)];

    //TODO: DEFINE TIME TO START
    gameState = GameStates.play;
    gameTimer = Timer.periodic(Duration(milliseconds: (1000 * fps).floor()), getElapsedTime);
    update();
  }

  @override
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (1000 * fps).floor()), (timer) {
      builder(timer);
    });
  }

  void moveToLeft() {
    if (gameState == GameStates.play) {
      player.moveToLeft();
    }
  }

  void moveToRight() {
    if (gameState == GameStates.play) {
      player.moveToRight();
    }
  }

  void getElapsedTime(Timer timer) {}

  void updateFrame() {
    updateView();
  }

  void builder(Timer timer) {
    if (gameState == GameStates.play) {
      updateTime++;
      waitTime++;
      if (updateTime >= 9) {
        streetController.update();
        //gameBoard.printBoard();
        for (final car in cars) {
          if (car.ready) {
            car.clear();
            car.move();
          }
        }
        updateTime = 0;
        for (final car in cars) {
          if (!car.ready) {
            car.ready = true;
            car.column = math.Random().nextInt(10) <= 4 ? 3 : 6;
          }
        }
      }
      updateFrame();
    }
  }
}
