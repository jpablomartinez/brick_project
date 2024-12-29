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
              width: size.width * 0.65,
              decoration: BoxDecoration(
                border: Border.all(
                  color: BrickProjectColors.black,
                  width: 4,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: size.height * 0.68,
                child: const Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                            color: BrickProjectColors.black,
                            fontFamily: 'Digital',
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'SCORE',
                          style: TextStyle(
                            color: BrickProjectColors.black,
                            //fontFamily: 'Roboto',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
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
