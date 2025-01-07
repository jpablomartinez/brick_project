import 'dart:math' as math;
import 'package:brick_project/widgets/gamepad_button.dart';
import 'package:flutter/material.dart';

class Gamepad extends StatelessWidget {
  final Function leftButton;
  final Function rightButton;
  final Function topButton;
  final Function bottomButton;
  final Function rotateButtonDown;
  final Function rotateButtonUp;

  const Gamepad({
    super.key,
    required this.leftButton,
    required this.topButton,
    required this.rightButton,
    required this.bottomButton,
    required this.rotateButtonDown,
    required this.rotateButtonUp,
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
                  child: const Column(
                    children: [
                      Text(
                        'UP',
                        style: TextStyle(
                          color: Color.fromARGB(255, 226, 231, 233),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      GamepadButton(
                        margin: EdgeInsets.only(top: 4),
                        size: Size(40, 40),
                      )
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
                  child: const Column(
                    children: [
                      GamepadButton(
                        margin: EdgeInsets.only(bottom: 4),
                        size: Size(40, 40),
                      ),
                      Text(
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
                  child: const Column(
                    children: [
                      GamepadButton(
                        margin: EdgeInsets.only(bottom: 4),
                        size: Size(40, 40),
                      ),
                      Text(
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
                  child: const Column(
                    children: [
                      GamepadButton(
                        margin: EdgeInsets.only(bottom: 4),
                        size: Size(40, 40),
                      ),
                      Text(
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
          onTapDown: (_) => rotateButtonDown(),
          onTapUp: (_) => rotateButtonUp(),
          child: const Column(
            children: [
              GamepadButton(
                size: Size(80, 80),
                margin: EdgeInsets.symmetric(vertical: 8),
              ),
              Text(
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
