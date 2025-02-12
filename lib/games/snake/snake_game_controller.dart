import 'dart:math' as math;
import 'package:brick_project/core/game_controller.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/games/race/controllers/collision_controller.dart';
import 'package:brick_project/games/snake/models/apple.dart';
import 'package:brick_project/games/snake/models/snake.dart';
import 'package:brick_project/utils/constants.dart';

class SnakeGameControler extends IGame {
  int lives = maxLivesSnake;
  double gameTime = 0;
  double startTime = 0;
  double updateTime = 0;
  double winTime = 0;
  bool isForceReset = true;
  bool isGameOn = true;
  int actualRow = row;
  int points = 0;
  late BrickController brickController;
  late CollisionController collisionController;
  late Snake snake;
  late Apple apple;

  SnakeGameControler(this.brickController) {
    setAudioSettings();
  }

  void putElementsInBoard() {
    int appleCol = math.Random().nextInt(3) + 5;
    int appleRow = math.Random().nextInt(1) + 13;
    apple = Apple(
      appleRow,
      appleCol,
      brickController.gameBoard.board,
    );
    int snakeHeadRow = 5;
    int snakeHeadColumn = 4;
    snake = Snake(
      snakeHeadRow,
      snakeHeadColumn,
      brickController.gameBoard,
    );
  }

  @override
  void startGame() {
    collisionController = CollisionController();
    putElementsInBoard();
    brickController.audioSettings.playSfx('audios/race/start.wav');
    brickController.gameState = GameStates.start;
  }

  @override
  bool checkGameOver() {
    return lives == 0;
  }

  @override
  void checkWin() {
    if (points == snakeMaxPoints) {
      brickController.audioSettings.stop();
      brickController.audioSettings.playSfx('audios/win_1.mp3');
      brickController.gameState = GameStates.win;
    }
  }

  @override
  void down() {
    if (snake.direction == SnakeDirection.right || snake.direction == SnakeDirection.left) {
      snake.direction = SnakeDirection.down;
    }
  }

  @override
  int getLevel() {
    return 1;
  }

  @override
  int getLives() {
    return lives;
  }

  @override
  int getPoints() {
    return points;
  }

  @override
  bool getResetGame() {
    return isForceReset;
  }

  @override
  int getSpeed() {
    return 1;
  }

  @override
  void handleCollisionState() {
    collisionController.collisionTime += (1000 * fps);
    if (collisionController.isCollisionTimeComplete()) {
      brickController.audioSettings.pause();
      brickController.gameState = GameStates.restartView;
      collisionController.restartCollisionAnimation();
    }
  }

  @override
  void handleGameOver() {
    updateTime++;
    if (updateTime >= 15) {
      snake.auto();
      updateTime = 0;
    }
  }

  void checkCollision() {
    if (snake.checkCollision()) {
      brickController.gameState = GameStates.collision;
      lives--;
      brickController.audioSettings.playSfx('audios/race/collision.wav');
    }
  }

  @override
  void handlePlayState() {
    updateTime++;
    gameTime += (1000 * fps);
    if (updateTime >= 15) {
      snake.move(apple);
      updateTime = 0;
    }
    if (apple.hide) {
      apple.putAppleInBoard(brickController.gameBoard.board);
    }
    checkCollision();
    updatePoints();
    checkWin();
  }

  @override
  void handleRestartViewState() {
    brickController.restartController.restartTime += (1000 * fps);
    if (brickController.restartController.isDurationComplete()) {
      brickController.restartController.restartAnimation(brickController.gameBoard.board, actualRow--);
      brickController.restartController.resetRestartTime();
      if (actualRow == row * -1) {
        actualRow = row;
        brickController.restartController.resetRestartTime();
        if (isGameOn) {
          if (checkGameOver() || points == snakeMaxPoints) {
            brickController.gameState = GameStates.gameover;
            brickController.audioSettings.stop();
            //ugly
            if (points != snakeMaxPoints) brickController.audioSettings.playSfx('audios/game_over.mp3');
            snake = Snake(
              0,
              2,
              brickController.gameBoard,
            );
            snake.direction = SnakeDirection.right;
          } else {
            if (isForceReset) {
              brickController.audioSettings.playSfx('audios/race/start.wav');
              brickController.gameState = GameStates.start;
            } else {
              brickController.gameState = GameStates.play;
              brickController.audioSettings.playBackgroundAudio();
            }
            putElementsInBoard();
          }
        } else {
          isGameOn = false;
          brickController.gameState = GameStates.menu;
          brickController.audioSettings.addBackgroundSongs(['audios/background1.mp3', 'audios/background3.mp3']);
          brickController.audioSettings.playBackgroundAudio();
        }
      }
    }
  }

  @override
  void handleStartAnimation() {
    startTime += (1000 * fps);
    if (startTime > 2000) {
      brickController.gameBoard.printBoard();
      startTime = 0;
      brickController.gameState = GameStates.play;
      isForceReset = false;
      brickController.audioSettings.playBackgroundAudio();
    }
  }

  @override
  void left() {
    if (snake.direction == SnakeDirection.up || snake.direction == SnakeDirection.down) {
      snake.direction = SnakeDirection.left;
    }
  }

  @override
  void restart() {
    lives = maxLivesSnake;
    gameTime = 0;
    points = 0;
  }

  @override
  void right() {
    if (snake.direction == SnakeDirection.up || snake.direction == SnakeDirection.down) {
      snake.direction = SnakeDirection.right;
    }
  }

  @override
  void rotateButton(bool value) {}

  @override
  void setAudioSettings() {}

  @override
  void setLevel(int value) {}

  @override
  void setLives(int value) {}

  @override
  void setPoints(int value) {}

  @override
  void setResetGame(bool value) {
    isForceReset = value;
  }

  @override
  void setSpeed(int value) {}

  @override
  void shutdownGame() {
    isGameOn = false;
    brickController.gameState = GameStates.pause;
    brickController.audioSettings.stop();
    brickController.gameState = GameStates.restartView;
  }

  @override
  void up() {
    if (snake.direction == SnakeDirection.left || snake.direction == SnakeDirection.right) {
      snake.direction = SnakeDirection.up;
    }
  }

  @override
  void updateLevel() {}

  @override
  void updatePoints() {
    /*if ((gameTime / 1000).floor() > points) {
      points++;
    }*/
    points = snake.eatenApples;
  }

  @override
  void handleWinGame() {
    winTime += (1000 * fps);
    if (winTime > 2000) {
      winTime = 0;
      isForceReset = false;
      brickController.gameState = GameStates.restartView;
    }
  }
}
