import 'package:brick_project/colors.dart';
import 'package:flutter/material.dart';

class GameLayout extends StatelessWidget {
  final Widget child;
  const GameLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        Row(
          children: [
            Container(
              height: size.height * 0.68,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(
                  color: BrickProjectColors.black,
                  width: 4,
                ),
              ),
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
                          child: const Text(
                            '0',
                            style: TextStyle(
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
                    SizedBox(height: size.height * 0.2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: const Text(
                                '1',
                                style: TextStyle(
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
                              child: const Text(
                                '1',
                                style: TextStyle(
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
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }
}
