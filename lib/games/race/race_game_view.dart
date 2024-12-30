import 'package:brick_project/games/game_layout.dart';
import 'package:brick_project/games/race/controllers/race_game_controller.dart';
import 'package:flutter/material.dart';

class RaceGameView extends StatefulWidget {
  const RaceGameView({super.key});

  @override
  State<RaceGameView> createState() => _RaceGameState();
}

class _RaceGameState extends State<RaceGameView> {
  late RaceGameController raceGameController;

  @override
  void initState() {
    raceGameController = RaceGameController();
    raceGameController.startGame();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GameLayout(
      child: Container(),
    );
  }
}
