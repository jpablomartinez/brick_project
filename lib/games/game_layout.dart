import 'package:brick_project/colors.dart';
import 'package:flutter/material.dart';

class GameLayout extends StatelessWidget {
  final Widget child;
  final Widget gamepad;
  final Widget lives;
  final int points;
  final int speed;
  final int level;
  const GameLayout({
    super.key,
    required this.child,
    required this.gamepad,
    required this.lives,
    required this.points,
    required this.speed,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.07,
        ),
        Row(
          children: [
            Container(
              //height: size.height * 0.67,
              height: 540,
              width: 270,
              //width: size.height * 0.67 / 2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: BrickProjectColors.black,
                  width: 4,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: child,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: size.height * 0.68,
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
                    SizedBox(height: size.height * 0.05),
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
                    SizedBox(height: size.height * 0.2),
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          child: Row(
            children: [
              //options
              gamepad,
            ],
          ),
        ),
      ],
    );
  }
}
