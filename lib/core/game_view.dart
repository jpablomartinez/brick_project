import 'package:brick_project/core/audio_manager.dart';
import 'package:brick_project/core/interfaces/i_game.dart';
import 'package:brick_project/games/race/controllers/race_game_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:brick_project/utils/constants.dart';
import 'package:brick_project/games/game_layout.dart';
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
  late IGame gameController;
  late AudioSettings audioSettings;
  Widget board = const SizedBox();

  @override
  void initState() {
    audioSettings = AudioSettings();
    audioSettings.addBackgroundSongs(['audios/background1.mp3', 'audios/background3.mp3']);
    gameController = RaceGameController(audioSettings);
    gameController.startGame(() => update());
    board = draw();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget draw() {
    //area game
    //area game height = size.height * 0.68,
    //area game width = size.width * 0.7
    //square = size.width * 0.7 / 10
    List<Widget> rows = [];
    List<Widget> cols = [];
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < colums; j++) {
        if (gameController.getGameBoard().cellIsOne(i, j)) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameLayout(
      gamepad: Gamepad(
        leftButton: () => gameController.left(),
        topButton: () => gameController.up(),
        rightButton: () => gameController.right(),
        bottomButton: () => gameController.down(),
        rotateButtonDown: () => gameController.rotateButton(true),
        rotateButtonUp: () => gameController.rotateButton(false),
      ),
      points: gameController.getPoints(),
      lives: renderLives(),
      speed: gameController.getSpeed(),
      level: gameController.getLevel(),
      gamepadActions: GamepadActions(
        soundHandler: () => audioSettings.mute(),
        onOffHandler: () {},
        resetHandler: () {
          gameController.setResetGame(true);
          audioSettings.stop();
          gameController.setGameStates(GameStates.restartView);
          gameController.restart();
        },
        pauseHandler: () {
          if (gameController.getGameStates() == GameStates.pause) {
            gameController.play();
          } else if (gameController.getGameStates() == GameStates.play) {
            gameController.pause();
          }
        },
      ),
      gameOver: gameController.getGameStates() == GameStates.gameover,
      child: Container(
        color: BrickProjectColors.background,
        child: board,
      ),
    );
  }
}
