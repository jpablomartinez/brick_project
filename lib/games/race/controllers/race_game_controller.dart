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
  bool accelerate = false;
  int points = 0;
  int lives = raceCarGameLives;
  double updateTime = 0;
  double gameTime = 0;
  double restartTime = 0;
  bool full = true;
  int actualRow = row;
  List<int> levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> raceCarGameLevels = [
    raceCarGameSecondsPerLevel_1,
    raceCarGameSecondsPerLevel_2,
    raceCarGameSecondsPerLevel_3,
    raceCarGameSecondsPerLevel_4,
    raceCarGameSecondsPerLevel_5,
    raceCarGameSecondsPerLevel_6,
    raceCarGameSecondsPerLevel_7,
    raceCarGameSecondsPerLevel_8,
    raceCarGameSecondsPerLevel_9,
    raceCarGameSecondsPerLevel_10,
  ];
  var gameState = GameStates.play;
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
    gameState = GameStates.pause;
    update();
  }

  @override
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (1000 * fps).floor()), (timer) {
      builder(timer);
    });
  }

  @override
  void restart() {
    gameState = GameStates.restart;
    points = 0;
    lives = raceCarGameLives;
    speed = 1;
    level = 1;
    accelerate = false;
  }

  @override
  void updatePoints() {
    if ((gameTime / 1000).floor() > points) {
      points++;
    }
  }

  @override
  void updateLevel() {
    for (int i = 0; i < levels.length - 1; i++) {
      if (level == levels[i] && (gameTime / 1000).floor() == raceCarGameLevels[i]) {
        level++;
        if (level % 2 == 0) {
          speed++;
        }
      }
    }
  }

  @override
  void builder(Timer timer) {
    if (gameState == GameStates.play) {
      updateTime++;
      gameTime += (1000 * fps);
      int localSpeed = accelerate ? 3 : 8 - speed;
      if (updateTime >= localSpeed) {
        streetController.update();
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
            cars[(i + 1) % cars.length].start(math.Random().nextInt(10));
          }
        }
      }
      checkGameOver();
      checkWin();
      updateLevel();
      updatePoints();
    }
    if (gameState == GameStates.restart) {
      restartTime += (1000 * fps);
      if (restartTime > 60) {
        restartAnimation(actualRow--);
        restartTime = 0;
        if (actualRow == row * -1) {
          actualRow = row;
          restartTime = 0;
          streetController.create();
          player.changePosition(0, 1);
          int first = math.Random().nextInt(10); // Value is >= 0 and < 10.
          int second = math.Random().nextInt(10); // Value is >= 0 and < 10.
          cars = [NpcCar(first, gameBoard), NpcCar(second, gameBoard, r: false)];
          //TODO: DEFINE TIME TO START
          gameState = GameStates.play;
        }
      }
    }
    updateFrame();
  }

  @override
  void checkGameOver() {
    //CHECK COLLISIONS AND LIVES
    if (lives == 0) {
      //TRIGGER GAME OVER
      gameState = GameStates.gameover;
    }
  }

  @override
  void checkWin() {
    if (level == 10 && (gameTime / 1000).floor() == raceCarGameSecondsPerLevel_10) {
      gameState = GameStates.win;
    }
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

  @override
  void pause() {
    gameState = GameStates.pause;
  }

  @override
  void play() {
    gameState = GameStates.play;
  }

  void acceleration(bool value) {
    accelerate = value;
  }

  void fullBoard(int localRow) {
    for (int i = localRow - 1; i > localRow - 2; i--) {
      for (int j = 0; j < colums; j++) {
        gameBoard.board[i][j] = 1;
      }
    }
  }

  void cleanBoard(int localRow) {
    for (int i = localRow * -1; i < (localRow * -1) + 1 && (localRow * -1) < row; i++) {
      for (int j = 0; j < colums; j++) {
        gameBoard.board[i][j] = 0;
      }
    }
  }

  void restartAnimation(int localRow) {
    if (localRow > 0) {
      fullBoard(localRow);
    } else {
      cleanBoard(localRow);
    }
  }
}
