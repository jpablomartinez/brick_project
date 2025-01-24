import 'dart:math' as math;
import 'package:brick_project/core/game_controller.dart';
import 'package:brick_project/utils/constants.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/games/race/controllers/collision_controller.dart';
import 'package:brick_project/games/race/controllers/street_controller.dart';
import 'package:brick_project/games/race/models/car.dart';
import 'package:brick_project/games/race/models/npc_car.dart';

class RaceGameController extends IGame {
  int level = 1;
  int speed = 1;
  int leftSpawn = 0;
  int rightSpawn = 0;
  bool accelerate = false;
  int points = 0;
  int lives = maxLives;
  double updateTime = 0;
  double gameTime = 0;
  double startTime = 0;
  bool full = true;
  bool forceReset = false;
  bool isGameOn = true;
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
  late BrickController brickController;
  late StreetController streetController;
  late CollisionController collisionController;
  late Car player;
  late List<NpcCar> cars;

  RaceGameController(BrickController controller) {
    brickController = controller;
    brickController.handleStartAnimation = handleStartAnimation;
    brickController.handlePlayState = handlePlayState;
    brickController.handleRestartViewState = handleRestartViewState;
    brickController.handleCollisionState = handleCollisionState;
    brickController.handleGameOver = handleGameOver;
    setAudioSettings();
  }

  /// Initializes and starts the race game.
  ///
  /// This method sets up the game board, initializes controllers, and places
  /// game elements on the board. It also sets the game state to play and
  /// begins the game update loop.
  ///
  /// [frameUpdate] is a callback function that updates the game view.
  @override
  void startGame() {
    streetController = StreetController();
    collisionController = CollisionController();
    player = Car(brickController.gameBoard);
    restart();
    putElementsInBoard();
    brickController.audioSettings.playSfx('audios/race/start.wav');
    brickController.gameState = GameStates.start;
  }

  /// Resets the game state to its initial values.
  ///
  /// This method reinitializes the game variables such as lives, game time,
  /// points, speed, level, and acceleration status to their starting values.
  @override
  void restart() {
    lives = maxLives;
    gameTime = 0;
    points = 0;
    speed = 1;
    level = 1;
    accelerate = false;
  }

  /// Updates the player's points based on the elapsed game time.
  ///
  /// Increments the points by 1 if the integer value of the game time
  /// in seconds exceeds the current points.
  @override
  void updatePoints() {
    if ((gameTime / 1000).floor() > points) {
      points++;
    }
  }

  /// Updates the game level based on elapsed game time.
  ///
  /// This method iterates through the levels and checks if the current
  /// level matches a predefined level and if the elapsed game time in
  /// seconds matches the corresponding time for that level. If both
  /// conditions are met, the level is incremented. Additionally, if the
  /// new level is even, the speed is increased.
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

  /// Handles the play state of the race game.
  ///
  /// This method updates the game time and manages the movement of NPC cars
  /// based on the current speed and acceleration status. It checks for collisions,
  /// game over conditions, and winning conditions, and updates the game level
  /// and player points accordingly. The street and car positions are updated
  /// periodically based on the local speed.
  @override
  void handlePlayState() {
    updateTime++;
    gameTime += (1000 * fps);
    int localSpeed = accelerate ? 3 : 8 - speed;
    if (updateTime >= localSpeed) {
      streetController.update(brickController.gameBoard.board);
      for (final car in cars) {
        if (car.ready) {
          car.clear();
          car.move();
        }
      }
      updateTime = 0;
      for (int i = 0; i < cars.length; i++) {
        final car = cars[i];
        if (car.body[3] == 12 && !cars[(i + 1) % cars.length].ready) {
          int pos = math.Random().nextInt(10);
          if (pos < 5) {
            if (leftSpawn >= 2) {
              leftSpawn = 0;
              pos = 5;
            } else {
              leftSpawn++;
              rightSpawn = 0;
            }
          } else {
            if (rightSpawn >= 2) {
              rightSpawn = 0;
              pos = 4;
            } else {
              rightSpawn++;
              leftSpawn = 0;
            }
          }
          cars[(i + 1) % cars.length].start(pos);
        }
      }
    }
    checkCollision();
    checkWin();
    updateLevel();
    updatePoints();
  }

  @override
  void handleStartAnimation() {
    startTime += (1000 * fps);
    if (startTime > 2000) {
      startTime = 0;
      brickController.gameState = GameStates.play;
      forceReset = false;
      brickController.audioSettings.playBackgroundAudio();
    }
  }

  /// Handles the restart view state of the race game.
  ///
  /// This method increments the restart time and checks if the duration
  /// is complete. If complete, it triggers the restart animation and
  /// resets the restart time. Once the animation reaches the initial row,
  /// it resets the row, places elements back on the board, and changes
  /// the game state to play.
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
          if (checkGameOver()) {
            brickController.gameState = GameStates.gameover;
            brickController.audioSettings.stop();
            brickController.audioSettings.playSfx('audios/game_over.mp3');
            streetController.create(brickController.gameBoard.board);
            int first = math.Random().nextInt(10);
            int second = math.Random().nextInt(10);
            cars = [NpcCar(first, brickController.gameBoard), NpcCar(second, brickController.gameBoard, r: false)];
          } else {
            if (forceReset) {
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

  /// Handles the collision state of the race game.
  ///
  /// This method updates the collision time and checks if the collision
  /// time is complete. If complete, it triggers the collision animation
  /// and resets the collision time. It also checks if the collision
  /// animation frame or the entire animation is complete, and updates
  /// the game state to restart view if necessary. Additionally, it
  /// resets the player's position and collision animation state.
  @override
  void handleCollisionState() {
    collisionController.collisionTime += (1000 * fps);
    if (collisionController.isCollisionTimeComplete()) {
      collisionController.collisionAnimation(brickController.gameBoard.board, player);
      collisionController.restartCollisionTime();
      if (collisionController.isCollisionAnimatioFrameEnd()) {
        collisionController.restartCollisionAnimationFrame();
      } else if (collisionController.isCollisionAnimationComplete()) {
        brickController.audioSettings.pause();
        brickController.gameState = GameStates.restartView;
        player.leftLane = true;
        collisionController.restartCollisionAnimation();
      }
    }
  }

  /// Handles the game over state by updating the street and NPC cars.
  ///
  /// This method increments the update time and checks if it meets or exceeds
  /// the local speed threshold. If so, it updates the street and moves NPC cars
  /// that are ready. It also resets the update time and starts the next car
  /// in sequence if conditions are met.
  @override
  void handleGameOver() {
    updateTime++;
    int localSpeed = 8;
    if (updateTime >= localSpeed) {
      streetController.update(brickController.gameBoard.board);
      for (final car in cars) {
        if (car.ready) {
          car.clear();
          car.move();
        }
      }
      updateTime = 0;
      for (int i = 0; i < cars.length; i++) {
        final car = cars[i];
        if (car.body[3] == 12 && !cars[(i + 1) % cars.length].ready) {
          cars[(i + 1) % cars.length].start(math.Random().nextInt(10));
        }
      }
    }
  }

  /// Checks for collisions on the game board.
  ///
  /// This method iterates over a specific section of the game board to
  /// detect collisions. If a collision is detected (indicated by a value
  /// of 2 on the board), it decrements the player's lives and changes
  /// the game state to `collision`.
  void checkCollision() {
    bool collision = false;
    for (int i = 16; i < row && !collision; i++) {
      for (int j = 0; j < colums; j++) {
        if (brickController.gameBoard.board[i][j] == 2) {
          brickController.gameState = GameStates.collision;
          lives--;
          brickController.audioSettings.playSfx('audios/race/collision.wav');
          collision = true;
          break;
        }
      }
    }
  }

  /// Checks if the game is over by evaluating the player's lives.
  ///
  /// If the player's lives are reduced to zero, the game state is set
  /// to `gameover`, indicating the end of the game.
  @override
  bool checkGameOver() {
    return lives == 0;
  }

  /// Checks if the player has won the game.
  ///
  /// This method evaluates the current level and game time to determine
  /// if the win condition is met. If the player reaches level 10 and the
  /// elapsed game time matches the predefined time for level 10, the game
  /// state is set to `win`.
  @override
  void checkWin() {
    if (level == 10 && (gameTime / 1000).floor() == raceCarGameSecondsPerLevel_10) {
      brickController.gameState = GameStates.win;
    }
  }

  /// Moves the player's car to the left.
  ///
  /// This method checks if the game is currently in the play state
  /// and, if so, instructs the player's car to move left.
  @override
  void left() {
    if (brickController.gameState == GameStates.play) {
      brickController.audioSettings.playGamepad('audios/arrow_button.wav');
      player.moveToLeft();
    }
  }

  /// Moves the player's car to the right.
  ///
  /// This method checks if the game is currently in the play state
  /// and, if so, instructs the player's car to move right.
  @override
  void right() {
    if (brickController.gameState == GameStates.play) {
      brickController.audioSettings.playGamepad('audios/arrow_button.wav');
      player.moveToRight();
    }
  }

  @override
  void down() {}

  @override
  void up() {}

  /// Sets the acceleration state of the player's car.
  ///
  /// This method updates the `accelerate` flag, which determines
  /// whether the player's car is in an accelerated state.
  ///
  /// [value] A boolean indicating the desired acceleration state.
  @override
  void rotateButton(bool value) {
    accelerate = value;
  }

  /// Pauses the race game.
  ///
  /// This method sets the game state to `pause`, halting all game
  /// activities until the game is resumed.
  @override
  void pause() {
    brickController.gameState = GameStates.pause;
    brickController.audioSettings.pause();
  }

  /// Sets the game state to 'play'.
  ///
  /// This method changes the current game state to 'play', allowing
  /// the game to resume or continue its active state.
  @override
  void play() {
    brickController.gameState = GameStates.play;
    brickController.audioSettings.resume();
  }

  /// Places game elements on the game board.
  ///
  /// This method initializes the street and moves the player's car to the left.
  /// It also randomly generates positions for two NPC cars and places them on
  /// the game board.
  void putElementsInBoard() {
    streetController.create(brickController.gameBoard.board);
    player.move(3);
    int first = math.Random().nextInt(10);
    if (first < 5) {
      leftSpawn++;
    } else if (first > 4) {
      rightSpawn++;
    }
    int second = math.Random().nextInt(10);
    if (second < 5) {
      leftSpawn++;
    } else if (second > 4) {
      rightSpawn++;
    }
    cars = [NpcCar(first, brickController.gameBoard), NpcCar(second, brickController.gameBoard, r: false)];
  }

  @override
  void setAudioSettings() {
    //audioSettings = AudioSettings();
    brickController.audioSettings.addBackgroundSongs(['audios/background1.mp3', 'audios/background3.mp3']);
  }

  @override
  int getLevel() {
    return level;
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
  int getSpeed() {
    return speed;
  }

  @override
  void setLevel(int value) {
    level = value;
  }

  @override
  void setLives(int value) {
    lives = value;
  }

  @override
  void setPoints(int value) {
    points = value;
  }

  @override
  void setSpeed(int value) {
    speed = value;
  }

  @override
  bool getResetGame() {
    return forceReset;
  }

  @override
  void setResetGame(bool value) {
    forceReset = value;
  }

  @override
  void shutdownGame() {
    isGameOn = false;
    brickController.gameState = GameStates.pause;
    brickController.audioSettings.stop();
    brickController.gameState = GameStates.restartView;
  }
}
