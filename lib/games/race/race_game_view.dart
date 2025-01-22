import 'package:brick_project/core/audio_manager.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:brick_project/utils/constants.dart';
import 'package:brick_project/games/game_layout.dart';
import 'package:brick_project/games/race/controllers/race_game_controller.dart';
import 'package:brick_project/widgets/gamepad.dart';
import 'package:brick_project/widgets/gamepad_actions.dart';
import 'package:brick_project/widgets/square.dart';
import 'package:flutter/material.dart';

class RaceGameView extends StatefulWidget {
  final Size size;
  final AudioSettings audioSettings;
  const RaceGameView({
    super.key,
    required this.size,
    required this.audioSettings,
  });

  @override
  State<RaceGameView> createState() => _RaceGameState();
}

class _RaceGameState extends State<RaceGameView> {
  late RaceGameController raceGameController;
  Widget board = const SizedBox();

  @override
  void initState() {
    raceGameController = RaceGameController(widget.audioSettings);
    raceGameController.startGame(() => update());
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
        if (raceGameController.gameBoard.board[i][j] == 1) {
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
      if (i <= raceGameController.lives) {
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
        leftButton: () => raceGameController.moveToLeft(),
        topButton: () {},
        rightButton: () => raceGameController.moveToRight(),
        bottomButton: () {},
        rotateButtonDown: () => raceGameController.acceleration(true),
        rotateButtonUp: () => raceGameController.acceleration(false),
      ),
      points: raceGameController.points,
      lives: renderLives(),
      speed: raceGameController.speed,
      level: raceGameController.level,
      gamepadActions: GamepadActions(
        soundHandler: () => raceGameController.audioSettings.mute(),
        onOffHandler: () {},
        resetHandler: () {
          raceGameController.forceReset = true;
          raceGameController.audioSettings.stop();
          raceGameController.gameState = GameStates.restartView;
          raceGameController.restart();
        },
        pauseHandler: () {
          if (raceGameController.gameState == GameStates.pause) {
            raceGameController.play();
          } else if (raceGameController.gameState == GameStates.play) {
            raceGameController.pause();
          }
        },
      ),
      gameOver: raceGameController.gameState == GameStates.gameover,
      child: Container(
        color: BrickProjectColors.background,
        child: board,
      ),
    );
  }
}
