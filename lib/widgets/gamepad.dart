import 'dart:math' as math;
import 'package:flutter/material.dart';

class Gamepad extends StatelessWidget {
  final Function leftButton;
  final Function rightButton;
  final Function topButton;
  final Function bottomButton;

  const Gamepad({
    super.key,
    required this.leftButton,
    required this.topButton,
    required this.rightButton,
    required this.bottomButton,
  });

  final double gamepadWidth = 180;
  final double gamepadHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: gamepadWidth,
          height: gamepadHeight,
          child: Stack(
            children: [
              //top button
              Positioned(
                top: 0,
                left: gamepadWidth / 3,
                right: gamepadWidth / 3,
                child: GestureDetector(
                  onTap: () => topButton(),
                  child: Column(
                    children: [
                      const Text(
                        'UP',
                        style: TextStyle(
                          color: Color.fromARGB(255, 226, 231, 233),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 223, 207, 87),
                          border: Border.all(color: const Color.fromARGB(255, 118, 111, 55), width: 3, strokeAlign: BorderSide.strokeAlignOutside),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //bottom button
              Positioned(
                bottom: 4,
                left: gamepadWidth / 3,
                right: gamepadWidth / 3,
                child: GestureDetector(
                  onTap: () => bottomButton(),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 223, 207, 87),
                          border: Border.all(color: const Color.fromARGB(255, 118, 111, 55), width: 3, strokeAlign: BorderSide.strokeAlignOutside),
                        ),
                      ),
                      const Text(
                        'BOTTOM',
                        style: TextStyle(
                          color: Color.fromARGB(255, 226, 231, 233),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: gamepadWidth / 2 + 4,
                left: gamepadWidth / 2.7,
                right: gamepadWidth / 2.7,
                child: Container(
                  width: gamepadWidth / 3,
                  height: 3,
                  color: const Color.fromARGB(255, 226, 231, 233),
                ),
              ),
              //left button
              Positioned(
                top: gamepadHeight / 3 + 4,
                left: 4,
                child: GestureDetector(
                  onTap: () => leftButton(),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 223, 207, 87),
                          border: Border.all(color: const Color.fromARGB(255, 118, 111, 55), width: 3, strokeAlign: BorderSide.strokeAlignOutside),
                        ),
                      ),
                      const Text(
                        'LEFT',
                        style: TextStyle(
                          color: Color.fromARGB(255, 226, 231, 233),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              //rigth button
              Positioned(
                top: gamepadHeight / 3 + 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => rightButton(),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 223, 207, 87),
                          border: Border.all(color: const Color.fromARGB(255, 118, 111, 55), width: 3, strokeAlign: BorderSide.strokeAlignOutside),
                        ),
                      ),
                      const Text(
                        'RIGHT',
                        style: TextStyle(
                          color: Color.fromARGB(255, 226, 231, 233),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: gamepadWidth / 2 + 4,
                left: gamepadWidth / 2.7,
                right: gamepadWidth / 2.7,
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Container(
                    height: 3,
                    color: const Color.fromARGB(255, 226, 231, 233),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 120,
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 207, 87),
                  border: Border.all(color: const Color.fromARGB(255, 118, 111, 55), width: 3, strokeAlign: BorderSide.strokeAlignOutside),
                  shape: BoxShape.circle,
                ),
              ),
              const Text(
                'ROTATE \nDIRECTION',
                style: TextStyle(
                  color: Color.fromARGB(255, 226, 231, 233),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        )
      ],
    );
  }
}
