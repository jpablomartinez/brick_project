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
  int lives = raceCarGameLives;
  double updateTime = 0;
  double gameTime = 0;
  var gameState = GameStates.start;
  late GameBoard gameBoard;
  late StreetController streetController;
  late Timer frameTimer;
  late Function updateView;
  late Car player;
  late List<NpcCar> cars;

  @override
  void startGame(Function frameUpdate) {
    gameBoard = GameBoard();
    restart();
    streetController = StreetController(gameBoard);
    streetController.create();
    updateView = frameUpdate;
    player = Car(true, gameBoard);
    int first = math.Random().nextInt(10); // Value is >= 0 and < 10.
    int second = math.Random().nextInt(10); // Value is >= 0 and < 10.
    cars = [NpcCar(first, gameBoard), NpcCar(second, gameBoard, r: false)];
    //TODO: DEFINE TIME TO START
    gameState = GameStates.play;
    update();
  }

  @override
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (1000 * fps).floor()), (timer) {
      builder(timer);
    });
  }

  //TODO: ADD TO INTERFACE IGAME
  void restart() {
    points = 0;
    lives = raceCarGameLives;
    speed = 1;
    level = 1;
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

  void updateFrame() {
    updateView();
  }

  //TODO: ADD TO INTERFACE IGAME
  void builder(Timer timer) {
    if (gameState == GameStates.play) {
      updateTime++;
      gameTime += (1000 / 60);
      if (updateTime >= 5) {
        streetController.update();
        //gameBoard.printBoard();
        for (final car in cars) {
          if (car.ready) {
            car.clear();
            car.move();
          }
        }
        updateTime = 0;
        for (int i = 0; i < cars.length; i++) {
          final car = cars[i];
          if (car.positions[3] == 12 && !cars[(i + 1) % cars.length].ready) {
            cars[(i + 1) % cars.length].ready = true;
            cars[(i + 1) % cars.length].column = NpcCar.getStartPosition(math.Random().nextInt(10));
          }
        }
      }
      if ((gameTime / 1000).floor() > points) {
        points++;
      }
      updateFrame();
    }
  }
}
