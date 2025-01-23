import 'package:brick_project/core/game_controller.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/core/menu/main_menu_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:brick_project/utils/constants.dart';
import 'package:brick_project/games/game_layout.dart';
import 'package:brick_project/widgets/game_selector.dart';
import 'package:brick_project/widgets/gamepad.dart';
import 'package:brick_project/widgets/gamepad_actions.dart';
import 'package:brick_project/widgets/square.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  final Size size;
  const GameView({
    super.key,
    required this.size,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  Widget board = const SizedBox();
  Widget lives = const SizedBox();
  late BrickController brickController;
  late IGame gameController;

  @override
  void initState() {
    brickController = BrickController(update);
    gameController = MainMenuController(brickController, selectGame);
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
    gameController.startGame();
  }

  Widget draw() {
    //area game
    //area game height = size.height * 0.68,
    //area game width = size.width * 0.7
    //square = size.width * 0.7 / 10

    if (brickController.gameState == GameStates.menu) {
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
      List<Widget> rows = [];
      List<Widget> cols = [];
      for (int i = 0; i < row; i++) {
        for (int j = 0; j < colums; j++) {
          if (brickController.gameBoard.cellIsOne(i, j)) {
            cols.add(
              const Square(
                width: 27,
                height: 27,
              ),
            );
          } else {
            cols.add(
              const BackgroundSquare(
                width: 27,
                height: 27,
              ),
            );
          }
        }
        rows.add(Row(children: cols));
        cols = [];
      }
      return Column(children: rows);
    }
  }

  Widget renderLives() {
    List<Widget> col = [];
    for (int i = 4; i > 0; i--) {
      if (i <= gameController.getLives()) {
        col.add(
          const Square(
            width: 27,
            height: 27,
          ),
        );
      } else {
        col.add(
          const BackgroundSquare(
            width: 27,
            height: 27,
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Column(
          children: [
            BackgroundSquare(
              width: 27,
              height: 27,
            ),
            BackgroundSquare(
              width: 27,
              height: 27,
            ),
            BackgroundSquare(
              width: 27,
              height: 27,
            ),
            BackgroundSquare(
              width: 27,
              height: 27,
            ),
          ],
        ),
        Row(
          children: [
            Column(children: col),
            Column(children: col),
          ],
        ),
        const Column(
          children: [
            BackgroundSquare(
              width: 28,
              height: 28,
            ),
            BackgroundSquare(
              width: 28,
              height: 28,
            ),
            BackgroundSquare(
              width: 28,
              height: 28,
            ),
            BackgroundSquare(
              width: 28,
              height: 28,
            ),
          ],
        ),
      ],
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
        gamepad: Gamepad(
          leftButton: () => gameController.left(),
          topButton: () => gameController.up(),
          rightButton: () => gameController.right(),
          bottomButton: () => gameController.down(),
          rotateButtonDown: () => gameController.rotateButton(true),
          rotateButtonUp: () => gameController.rotateButton(false),
        ),
        points: gameController.getPoints(),
        lives: lives,
        speed: gameController.getSpeed(),
        level: gameController.getLevel(),
        gamepadActions: GamepadActions(
          soundHandler: () => brickController.audioSettings.mute(),
          onOffHandler: () {},
          resetHandler: () {
            if (brickController.gameState != GameStates.menu) {
              gameController.setResetGame(true);
              brickController.audioSettings.stop();
              brickController.gameState = GameStates.restartView;
              gameController.restart();
            }
          },
          pauseHandler: () {
            if (brickController.gameState == GameStates.pause) {
              gameController.play();
            } else if (brickController.gameState == GameStates.play) {
              gameController.pause();
            }
          },
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
