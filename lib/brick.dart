import 'package:brick_project/core/game_view.dart';
import 'package:brick_project/core/size_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:flutter/material.dart';

class BrickGames extends StatefulWidget {
  const BrickGames({super.key});

  @override
  State<BrickGames> createState() => _BrickGamesState();
}

class _BrickGamesState extends State<BrickGames> {
  SizeController? sizeController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        //padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: BrickProjectColors.black),
        child: GameView(
          sizeController: SizeController(size.height, size.width),
        ), //RaceGameView(size: size),
      ),
    );
  }
}
