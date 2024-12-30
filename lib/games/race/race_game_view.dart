import 'package:brick_project/core/constants.dart';
import 'package:brick_project/games/game_layout.dart';
import 'package:brick_project/games/race/controllers/race_game_controller.dart';
import 'package:brick_project/widgets/square.dart';
import 'package:flutter/material.dart';

class RaceGameView extends StatefulWidget {
  final Size size;
  const RaceGameView({super.key, required this.size});

  @override
  State<RaceGameView> createState() => _RaceGameState();
}

class _RaceGameState extends State<RaceGameView> {
  late RaceGameController raceGameController;
  late Widget board;

  @override
  void initState() {
    raceGameController = RaceGameController();
    raceGameController.startGame();
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
              width: 30,
              height: 30,
            ),
          );
        } else {
          cols.add(
            const BackgroundSquare(
              width: 30,
              height: 30,
            ),
          );
        }
      }
      rows.add(Row(children: cols));
      cols = [];
    }
    return Column(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return GameLayout(
      child: Container(
        child: board,
      ),
    );
  }
}