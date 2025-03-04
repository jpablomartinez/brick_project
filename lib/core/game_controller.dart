import 'dart:async';

import 'package:brick_project/core/audio_manager.dart';
import 'package:brick_project/core/fps_controller.dart';
import 'package:brick_project/core/game_board.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/core/restart_controller.dart';
import 'package:brick_project/games/race/controllers/race_game_controller.dart';
import 'package:brick_project/games/snake/snake_game_controller.dart';
import 'package:brick_project/utils/constants.dart';

class Game {
  String title;
  bool selected;

  Game(this.title, this.selected);

  void deselect() {
    selected = false;
  }

  void select() {
    selected = true;
  }
}

class BrickController {
  late List<Game> games;
  late AudioSettings audioSettings;
  late FpsController fpsController;
  late RestartController restartController;
  late GameBoard gameBoard;
  late GameStates gameState;
  late Timer frameTimer;
  late Function updateView;
  late IGame gameController;
  int actualLives = 0;
  List<List<int>> lives = [];

  BrickController(Function u) {
    games = [
      Game('race', true),
      Game('snake', false),
    ];
    audioSettings = AudioSettings();
    audioSettings.addBackgroundSongs(['audios/background1.mp3', 'audios/background3.mp3']);
    gameBoard = GameBoard();
    gameState = GameStates.menu;
    fpsController = FpsController();
    restartController = RestartController();
    audioSettings.playBackgroundAudio();
    updateView = u;
    update();
  }

  void setGameController(IGame controller) {
    gameController = controller;
    renderLivesArray();
    actualLives = gameController.getLives();
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
  void builder(Timer timer) {
    //fpsController.calculateFPS();
    //print(fpsController.fps);
    switch (gameState) {
      case GameStates.start:
        gameController.handleStartAnimation();
        break;
      case GameStates.play:
        gameController.handlePlayState();
        break;
      case GameStates.restartView:
        gameController.handleRestartViewState();
        break;
      case GameStates.collision:
        gameController.handleCollisionState();
        break;
      case GameStates.gameover:
        gameController.handleGameOver();
        break;
      case GameStates.win:
        gameController.handleWinGame();
      default:
        break;
    }
    updateFrame();
  }

  /// Starts a periodic timer to update the game state.
  ///
  /// This method initializes a `Timer` that triggers the `builder` method
  /// at intervals determined by the frames per second (fps) setting. The
  /// `builder` method is responsible for handling the current game state
  /// and updating the game frame accordingly.
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (1000 * fps).floor()), (timer) {
      builder(timer);
    });
  }

  /// Updates the game frame by invoking the view update callback.
  ///
  /// This method is responsible for refreshing the game view by calling
  /// the `updateView` function, which is expected to update the visual
  /// representation of the game state.
  void updateFrame() {
    updateView();
  }

  IGame? selectGame() {
    int index = games.indexWhere((e) => e.selected == true);
    switch (index) {
      case 0:
        return RaceGameController(this);
      case 1:
        return SnakeGameControler(this);
      case 2:
      default:
        return null;
    }
  }

  ///Maybe is better option has this array in the respective game controller (race, snake, etc)
  ///and change it when player lost a live
  void renderLivesArray() {
    if (actualLives != gameController.getLives()) {
      lives = [];
      for (int i = maxLivesRace; i > 0; i--) {
        if (i <= gameController.getLives()) {
          lives.add([0, 1, 1, 0]);
        } else {
          lives.add([0, 0, 0, 0]);
        }
      }
      actualLives = gameController.getLives();
    }
  }
}
