import 'package:brick_project/core/game_controller.dart';
import 'package:brick_project/utils/constants.dart';

abstract class IGame {
  int getLives();
  int getPoints();
  int getSpeed();
  int getLevel();

  /// Checks if the game is over by evaluating the player's lives.
  ///
  /// If the player's lives are reduced to zero, the game state is set
  /// to `gameover`, indicating the end of the game.
  bool checkGameOver();
  bool getResetGame();
  void setLives(int value);
  void setPoints(int value);
  void setSpeed(int value);
  void setLevel(int value);

  /// Initializes and starts the race game.
  ///
  /// This method sets up the game board, initializes controllers, and places
  /// game elements on the board. It also sets the game state to play and
  /// begins the game update loop.
  ///
  /// [frameUpdate] is a callback function that updates the game view.
  void startGame();

  /// Resets the game state to its initial values.
  ///
  /// This method reinitializes the game variables such as lives, game time,
  /// points, speed, level, and acceleration status to their starting values.
  void restart();

  /// Updates the player's points based on the elapsed game time.
  ///
  /// Increments the points by 1 if the integer value of the game time
  /// in seconds exceeds the current points.
  void updatePoints();

  /// Updates the game level based on elapsed game time.
  void updateLevel();

  /// Checks if the player has won the game.
  ///
  /// This method evaluates the current level and game time to determine
  /// if the win condition is met. If the player reaches level win and the
  /// elapsed game time matches the predefined time for level win, the game
  /// state is set to `win`.
  void checkWin();

  /// Pauses the actual game.
  ///
  /// This method sets the game state to `pause`, halting all game
  /// activities until the game is resumed.
  void pause(BrickController brickController) {
    brickController.gameState = GameStates.pause;
    brickController.audioSettings.pause();
  }

  /// Sets the game state to 'play'.
  ///
  /// This method changes the current game state to 'play', allowing
  /// the game to resume or continue its active state.
  void play(BrickController brickController) {
    brickController.gameState = GameStates.play;
    brickController.audioSettings.resume();
  }

  void setAudioSettings();

  /// Moves the player to the left.
  ///
  /// This method checks if the game is currently in the play state
  /// and, if so, instructs the player to move left.
  void left();

  /// Moves the player to the right.
  ///
  /// This method checks if the game is currently in the play state
  /// and, if so, instructs the player to move right.
  void right();
  void up();
  void down();
  void rotateButton(bool value);

  /// Handles the play state of the actual game.
  ///
  /// This method updates the game time. It checks for collisions,
  /// game over conditions, and winning conditions, and updates the game level
  /// and player points accordingly.
  void handlePlayState();

  /// Handles the collision state of the race game.
  ///
  /// This method updates the collision time and checks if the collision
  /// time is complete. If complete, it triggers the collision animation
  /// and resets the collision time. It also checks if the collision
  /// animation frame or the entire animation is complete, and updates
  /// the game state to restart view if necessary. Additionally, it
  /// resets the player's position and collision animation state.
  void handleCollisionState();
  void handleStartAnimation();

  /// Handles the game over state.
  ///
  /// This method increments the update time and checks if it meets or exceeds
  /// the local speed threshold. If so, it updates the street and moves NPC cars
  /// that are ready. It also resets the update time and starts the next car
  /// in sequence if conditions are met.
  void handleGameOver();

  /// Handles the restart view state of the actual game.
  ///
  /// This method increments the restart time and checks if the duration
  /// is complete. If complete, it triggers the restart animation and
  /// resets the restart time. Once the animation reaches the initial row,
  /// it resets the row, places elements back on the board, and changes
  /// the game state to play.
  void handleRestartViewState();
  void setResetGame(bool value);
  void shutdownGame();
  void handleWinGame();
}
