import 'package:brick_project/core/game_controller.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/core/menu/main_menu_controller.dart';
import 'package:brick_project/core/size_controller.dart';
import 'package:brick_project/core/vibrate_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:brick_project/utils/constants.dart';
import 'package:brick_project/games/game_layout.dart';
import 'package:brick_project/widgets/canvas_game.dart';
import 'package:brick_project/widgets/game_selector.dart';
import 'package:brick_project/widgets/gamepad.dart';
import 'package:brick_project/widgets/gamepad_actions.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  final SizeController sizeController;

  const GameView({
    super.key,
    required this.sizeController,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  Widget board = const SizedBox();
  Widget lives = const SizedBox();
  bool isMenuSetted = false;
  late BrickController brickController;
  late IGame gameController;
  late VibrateController vibrateController;

  @override
  void initState() {
    vibrateController = VibrateController();
    brickController = BrickController(update);
    gameController = MainMenuController(brickController, selectGame);
    brickController.setGameController(gameController);
    isMenuSetted = true;
    //gameController.startGame(() => update());
    board = draw();
    lives = renderLives();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectGame() {
    gameController = brickController.selectGame() ?? MainMenuController(brickController, () {});
    brickController.setGameController(gameController);
    isMenuSetted = false;
    gameController.startGame();
  }

  Widget draw() {
    //area game
    //area game height = size.height * 0.68,
    //area game width = size.width * 0.7
    //square = size.width * 0.7 / 10
    if (brickController.gameState == GameStates.menu) {
      if (!isMenuSetted) {
        gameController = MainMenuController(brickController, selectGame);
        brickController.setGameController(gameController);
        isMenuSetted = true;
      }
      List<Widget> games = [];
      for (var game in brickController.games) {
        games.add(
          GameSelector(
            title: game.title.toUpperCase(),
            selected: game.selected,
          ),
        );
      }
      return Column(children: games);
    } else {
      return CustomPaint(
        size: Size(widget.sizeController.screenWidth * 0.7, widget.sizeController.screenHeight * 0.68),
        painter: CanvasGame(brickController.gameBoard.board),
      );
    }
  }

  Widget renderLives() {
    //List<List<int>> lives = brickController.renderLivesArray();
    brickController.renderLivesArray();
    return CustomPaint(
      size: Size(widget.sizeController.cellBoard * 4, widget.sizeController.cellBoard * 4),
      painter: CanvasGame(brickController.lives),
    );
  }

  void update() {
    setState(() {
      board = draw();
      lives = renderLives();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GameLayout(
        sizeController: widget.sizeController,
        gamepad: Gamepad(
          sizeController: widget.sizeController,
          leftButton: () {
            vibrateController.vibrate();
            gameController.left();
          },
          topButton: () {
            vibrateController.vibrate();
            gameController.up();
          },
          rightButton: () {
            vibrateController.vibrate();
            gameController.right();
          },
          bottomButton: () {
            vibrateController.vibrate();
            gameController.down();
          },
          rotateButtonDown: () => gameController.rotateButton(true),
          rotateButtonUp: () => gameController.rotateButton(false),
        ),
        points: gameController.getPoints(),
        lives: lives,
        speed: gameController.getSpeed(),
        level: gameController.getLevel(),
        gamepadActions: GamepadActions(
          sizeController: widget.sizeController,
          soundHandler: () {
            vibrateController.vibrate();
            brickController.audioSettings.mute();
          },
          onOffHandler: () {
            vibrateController.vibrate();
            gameController.shutdownGame();
          },
          resetHandler: () {
            vibrateController.vibrate();
            if (brickController.gameState != GameStates.menu) {
              gameController.setResetGame(true);
              brickController.audioSettings.stop();
              brickController.gameState = GameStates.restartView;
              gameController.restart();
            }
          },
          pauseHandler: () {
            vibrateController.vibrate();
            if (brickController.gameState == GameStates.pause) {
              gameController.play(brickController);
            } else if (brickController.gameState == GameStates.play) {
              gameController.pause(brickController);
            }
          },
          gameStates: brickController.gameState,
        ),
        gameOver: brickController.gameState == GameStates.gameover,
        child: Container(
          color: BrickProjectColors.background,
          child: board,
        ),
      ),
    );
  }
}
