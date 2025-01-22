import 'dart:async';
import 'dart:math' as math;
import 'package:brick_project/core/audio_manager.dart';
import 'package:brick_project/utils/constants.dart';
import 'package:brick_project/core/fps_controller.dart';
import 'package:brick_project/core/game_board.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/core/restart_controller.dart';
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
  int lives = raceCarGameLives;
  double updateTime = 0;
  double gameTime = 0;
  double startTime = 0;
  bool full = true;
  bool forceReset = false;
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
  late CollisionController collisionController;
  late RestartController restartController;
  late FpsController fpsController;
  late Timer frameTimer;
  late Function updateView;
  late Car player;
  late List<NpcCar> cars;
  late AudioSettings audioSettings;

  RaceGameController(AudioSettings audio) {
    audioSettings = audio;
  }

  /// Initializes and starts the race game.
  ///
  /// This method sets up the game board, initializes controllers, and places
  /// game elements on the board. It also sets the game state to play and
  /// begins the game update loop.
  ///
  /// [frameUpdate] is a callback function that updates the game view.
  @override
  void startGame(Function frameUpdate) {
    gameBoard = GameBoard();
    streetController = StreetController();
    collisionController = CollisionController();
    restartController = RestartController();
    fpsController = FpsController();
    player = Car(gameBoard);
    updateView = frameUpdate;
    restart();
    putElementsInBoard();
    update();
    audioSettings.playSfx('audios/race/start.wav');
    gameState = GameStates.start;
  }

  /// Starts a periodic timer to update the game state.
  ///
  /// This method initializes a `Timer` that triggers the `builder` method
  /// at intervals determined by the frames per second (fps) setting. The
  /// `builder` method is responsible for handling the current game state
  /// and updating the game frame accordingly.
  @override
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (1000 * fps).floor()), (timer) {
      builder(timer);
    });
  }

  /// Resets the game state to its initial values.
  ///
  /// This method reinitializes the game variables such as lives, game time,
  /// points, speed, level, and acceleration status to their starting values.
  @override
  void restart() {
    lives = raceCarGameLives;
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

  /// Handles the game state updates based on the current game state.
  ///
  /// This method is called periodically by a timer to update the game state.
  /// It checks the current `gameState` and calls the appropriate handler
  /// method (`handlePlayState`, `handleRestartViewState`, or `handleCollisionState`)
  /// to manage the game logic for that state. After handling the state, it
  /// updates the game frame.
  ///
  /// [timer] is the periodic timer triggering this method.
  @override
  void builder(Timer timer) {
    //fpsController.calculateFPS();
    //print(fpsController.fps);
    switch (gameState) {
      case GameStates.start:
        handleStartAnimation();
        break;
      case GameStates.play:
        handlePlayState();
        break;
      case GameStates.restartView:
        handleRestartViewState();
        break;
      case GameStates.collision:
        handleCollisionState();
        break;
      case GameStates.gameover:
        handleGameOver();
        break;
      default:
        break;
    }
    updateFrame();
  }

  /// Handles the play state of the race game.
  ///
  /// This method updates the game time and manages the movement of NPC cars
  /// based on the current speed and acceleration status. It checks for collisions,
  /// game over conditions, and winning conditions, and updates the game level
  /// and player points accordingly. The street and car positions are updated
  /// periodically based on the local speed.
  void handlePlayState() {
    updateTime++;
    gameTime += (1000 * fps);
    int localSpeed = accelerate ? 3 : 8 - speed;
    if (updateTime >= localSpeed) {
      streetController.update(gameBoard.board);
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

  void handleStartAnimation() {
    startTime += (1000 * fps);
    if (startTime > 2000) {
      startTime = 0;
      gameState = GameStates.play;
      forceReset = false;
      audioSettings.playBackgroundAudio();
    }
  }

  /// Handles the restart view state of the race game.
  ///
  /// This method increments the restart time and checks if the duration
  /// is complete. If complete, it triggers the restart animation and
  /// resets the restart time. Once the animation reaches the initial row,
  /// it resets the row, places elements back on the board, and changes
  /// the game state to play.
  void handleRestartViewState() {
    restartController.restartTime += (1000 * fps);
    if (restartController.isDurationComplete()) {
      restartController.restartAnimation(gameBoard.board, actualRow--);
      restartController.resetRestartTime();
      if (actualRow == row * -1) {
        actualRow = row;
        restartController.resetRestartTime();
        if (checkGameOver()) {
          gameState = GameStates.gameover;
          audioSettings.stop();
          audioSettings.playSfx('audios/game_over.mp3');
          streetController.create(gameBoard.board);
          int first = math.Random().nextInt(10);
          int second = math.Random().nextInt(10);
          cars = [NpcCar(first, gameBoard), NpcCar(second, gameBoard, r: false)];
        } else {
          if (forceReset) {
            audioSettings.playSfx('audios/race/start.wav');
            gameState = GameStates.start;
          } else {
            gameState = GameStates.play;
            audioSettings.playBackgroundAudio();
          }
          putElementsInBoard();
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
  void handleCollisionState() {
    collisionController.collisionTime += (1000 * fps);
    if (collisionController.isCollisionTimeComplete()) {
      collisionController.collisionAnimation(gameBoard.board, player);
      collisionController.restartCollisionTime();
      if (collisionController.isCollisionAnimatioFrameEnd()) {
        collisionController.restartCollisionAnimationFrame();
      } else if (collisionController.isCollisionAnimationComplete()) {
        audioSettings.stop();
        gameState = GameStates.restartView;
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
  void handleGameOver() {
    updateTime++;
    int localSpeed = 8;
    if (updateTime >= localSpeed) {
      streetController.update(gameBoard.board);
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
    gameBoard.printBoard();
    for (int i = 16; i < row && !collision; i++) {
      for (int j = 0; j < colums; j++) {
        if (gameBoard.board[i][j] == 2) {
          gameState = GameStates.collision;
          lives--;
          audioSettings.playSfx('audios/race/collision.wav');
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
      gameState = GameStates.win;
    }
  }

  /// Moves the player's car to the left.
  ///
  /// This method checks if the game is currently in the play state
  /// and, if so, instructs the player's car to move left.
  void moveToLeft() {
    if (gameState == GameStates.play) {
      audioSettings.playGamepad('audios/arrow_button.wav');
      player.moveToLeft();
    }
  }

  /// Moves the player's car to the right.
  ///
  /// This method checks if the game is currently in the play state
  /// and, if so, instructs the player's car to move right.
  void moveToRight() {
    if (gameState == GameStates.play) {
      audioSettings.playGamepad('audios/arrow_button.wav');
      player.moveToRight();
    }
  }

  /// Updates the game frame by invoking the view update callback.
  ///
  /// This method is responsible for refreshing the game view by calling
  /// the `updateView` function, which is expected to update the visual
  /// representation of the game state.
  void updateFrame() {
    updateView();
  }

  /// Pauses the race game.
  ///
  /// This method sets the game state to `pause`, halting all game
  /// activities until the game is resumed.
  @override
  void pause() {
    gameState = GameStates.pause;
    audioSettings.pause();
  }

  /// Sets the game state to 'play'.
  ///
  /// This method changes the current game state to 'play', allowing
  /// the game to resume or continue its active state.
  @override
  void play() {
    gameState = GameStates.play;
    audioSettings.resume();
  }

  /// Sets the acceleration state of the player's car.
  ///
  /// This method updates the `accelerate` flag, which determines
  /// whether the player's car is in an accelerated state.
  ///
  /// [value] A boolean indicating the desired acceleration state.
  void acceleration(bool value) {
    accelerate = value;
  }

  /// Places game elements on the game board.
  ///
  /// This method initializes the street and moves the player's car to the left.
  /// It also randomly generates positions for two NPC cars and places them on
  /// the game board.
  void putElementsInBoard() {
    streetController.create(gameBoard.board);
    player.move(left);
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
    cars = [NpcCar(first, gameBoard), NpcCar(second, gameBoard, r: false)];
  }

  @override
  void setAudioSettings() {
    //audioSettings = AudioSettings();
    //audioSettings.addBackgroundSongs(['audios/background1.mp3', 'audios/background3.mp3']);
  }
}
