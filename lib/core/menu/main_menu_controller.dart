import 'package:brick_project/core/game_controller.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/utils/constants.dart';

class MainMenuController extends IGame {
  late BrickController brickController;
  late Function selectGame;
  int actualRow = row;

  MainMenuController(this.brickController, this.selectGame);

  @override
  bool checkGameOver() {
    return false;
  }

  @override
  void checkWin() {
    //
  }

  /// Moves the selection down in the game menu.
  ///
  /// Plays a sound effect for the down action and changes the selection
  /// to the next game in the list if the current selection is not the last one.
  @override
  void down() {
    brickController.audioSettings.playGamepad('audios/arrow_button.wav');
    int index = brickController.games.indexWhere((e) => e.selected == true);
    if (index < brickController.games.length - 1) {
      brickController.games[index].deselect();
      brickController.games[index + 1].select();
    }
  }

  @override
  int getLevel() {
    return 1;
  }

  @override
  int getLives() {
    return 4;
  }

  @override
  int getPoints() {
    return 9999;
  }

  @override
  bool getResetGame() {
    return false;
  }

  @override
  int getSpeed() {
    return 1;
  }

  @override
  void handleCollisionState() {
    //
  }

  @override
  void handleGameOver() {
    //
  }

  @override
  void handlePlayState() {
    //
  }

  /// Handles the logic for restarting the view state.
  ///
  /// This method is assigned to the `handleRestartViewState` property of
  /// the `brickController` to manage the view state reset process.
  @override
  void handleRestartViewState() {
    brickController.restartController.restartTime += (1000 * fps);
    if (brickController.restartController.isDurationComplete()) {
      brickController.restartController.restartAnimation(brickController.gameBoard.board, actualRow--);
      brickController.restartController.resetRestartTime();
      if (actualRow == row * -1) {
        actualRow = row;
        brickController.restartController.resetRestartTime();
        //start selected game
        brickController.gameState = GameStates.none;
        selectGame();
      }
    }
  }

  @override
  void handleStartAnimation() {
    //
  }

  @override
  void left() {
    //
  }

  @override
  void restart() {
    //
  }

  @override
  void right() {
    //
  }

  /// Stops the audio and sets the game state to restart view if the given value is true.
  ///
  /// This method is used to handle the logic when the rotate button is pressed.
  /// It stops any ongoing audio and changes the game state to `restartView`
  /// if the `value` parameter is true.
  @override
  void rotateButton(bool value) {
    brickController.audioSettings.stop();
    if (value) {
      //int index = brickController.games.indexWhere((e) => e.selected == true);
      brickController.gameState = GameStates.restartView;
    }
  }

  @override
  void setAudioSettings() {
    //
  }

  @override
  void setLevel(int value) {
    //
  }

  @override
  void setLives(int value) {
    //
  }

  @override
  void setPoints(int value) {
    //
  }

  @override
  void setResetGame(bool value) {
    //
  }

  @override
  void setSpeed(int value) {
    //
  }

  @override
  void startGame() {
    //
  }

  /// Moves the selection up in the game menu.
  ///
  /// Plays a sound effect for the up action and changes the selection
  /// to the previous game in the list if the current selection is not the first one.
  @override
  void up() {
    brickController.audioSettings.playGamepad('audios/arrow_button.wav');
    int index = brickController.games.indexWhere((e) => e.selected == true);
    if (index > 0) {
      brickController.games[index].deselect();
      brickController.games[index - 1].select();
    }
  }

  @override
  void updateLevel() {
    //
  }

  @override
  void updatePoints() {
    //
  }

  @override
  void shutdownGame() {
    //
  }

  @override
  void handleWinGame() {}
}
