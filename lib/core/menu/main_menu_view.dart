import 'package:brick_project/core/menu/menu_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:brick_project/games/game_layout.dart';
import 'package:brick_project/widgets/game_selector.dart';
import 'package:brick_project/widgets/gamepad.dart';
import 'package:brick_project/widgets/gamepad_actions.dart';
import 'package:brick_project/widgets/square.dart';
import 'package:flutter/material.dart';

class MainMenuView extends StatefulWidget {
  final Size size;
  const MainMenuView({super.key, required this.size});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  Widget board = const SizedBox();

  late MainMenuController mainMenuController;

  void update() {
    setState(() {
      board = draw();
    });
  }

  @override
  void initState() {
    mainMenuController = MainMenuController();
    mainMenuController.startGame(() => update());
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
    List<Widget> games = [];
    for (var game in mainMenuController.games) {
      games.add(
        GameSelector(
          title: game.title.toUpperCase(),
          selected: game.selected,
        ),
      );
    }
    return Column(children: games);
  }

  Widget renderLives() {
    List<Widget> col = [];
    for (int i = 4; i > 0; i--) {
      if (i <= 4) {
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

  @override
  Widget build(BuildContext context) {
    return GameLayout(
      gamepad: Gamepad(
        leftButton: () {},
        topButton: () => mainMenuController.upButton(),
        rightButton: () {},
        bottomButton: () => mainMenuController.downButton(),
        rotateButtonDown: () {},
        rotateButtonUp: () {},
      ),
      points: 9999,
      lives: renderLives(),
      speed: 1,
      level: 1,
      gamepadActions: GamepadActions(
        soundHandler: () {},
        onOffHandler: () {},
        resetHandler: () {},
        pauseHandler: () {},
      ),
      gameOver: false,
      child: Container(
        color: BrickProjectColors.background,
        child: board,
      ),
    );
  }
}
