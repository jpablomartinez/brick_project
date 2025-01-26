import 'package:brick_project/core/size_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:brick_project/widgets/game_over.dart';
import 'package:flutter/material.dart';

class GameLayout extends StatelessWidget {
  final Widget child;
  final Widget gamepad;
  final Widget gamepadActions;
  final Widget lives;
  final int points;
  final int speed;
  final int level;
  final bool gameOver;
  final SizeController sizeController;
  const GameLayout({
    super.key,
    required this.child,
    required this.gamepad,
    required this.gamepadActions,
    required this.lives,
    required this.points,
    required this.speed,
    required this.level,
    required this.gameOver,
    required this.sizeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 23, 23, 36),
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            decoration: BoxDecoration(
              color: BrickProjectColors.background,
              border: Border.all(
                color: const Color.fromARGB(255, 62, 63, 65),
                width: 3,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: sizeController.areaGameHeight,
                      //height: 540,
                      //width: 270,
                      width: sizeController.areaGameWidth,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: BrickProjectColors.black,
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: child,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: sizeController.screenHeight * 0.60,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '$points',
                                style: const TextStyle(
                                  color: BrickProjectColors.black,
                                  fontFamily: 'Digital',
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'SCORE',
                                style: TextStyle(
                                  color: BrickProjectColors.black,
                                  //fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sizeController.screenHeight * 0.05),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'LIVES',
                            style: TextStyle(
                              color: BrickProjectColors.black,
                              //fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        lives,
                        SizedBox(height: sizeController.screenHeight * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    '$speed',
                                    style: const TextStyle(
                                      color: BrickProjectColors.black,
                                      fontFamily: 'Digital',
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'SPEED',
                                    style: TextStyle(
                                      color: BrickProjectColors.black,
                                      //fontFamily: 'Roboto',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '$level',
                                    style: const TextStyle(
                                      color: BrickProjectColors.black,
                                      fontFamily: 'Digital',
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'LEVEL',
                                    style: TextStyle(
                                      color: BrickProjectColors.black,
                                      //fontFamily: 'Roboto',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: sizeController.screenHeight * 0.05),
                        gameOver ? const GameOverWidget() : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 16),
            width: sizeController.screenWidth,
            child: gamepadActions,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 4,
            ),
            child: gamepad,
          ),
        ],
      ),
    );
  }
}
