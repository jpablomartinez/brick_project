import 'dart:math' as math;
import 'package:brick_project/core/size_controller.dart';
import 'package:brick_project/widgets/gamepad_button.dart';
import 'package:flutter/material.dart';

class Gamepad extends StatelessWidget {
  final Function leftButton;
  final Function rightButton;
  final Function topButton;
  final Function bottomButton;
  final Function rotateButtonDown;
  final Function rotateButtonUp;
  final SizeController sizeController;

  const Gamepad({
    super.key,
    required this.leftButton,
    required this.topButton,
    required this.rightButton,
    required this.bottomButton,
    required this.rotateButtonDown,
    required this.rotateButtonUp,
    required this.sizeController,
  });

  final double gamepadWidth = 180;
  final double gamepadHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: sizeController.screenWidth * 0.48,
          height: sizeController.screenWidth * 0.45 + 20,
          child: Stack(
            children: [
              //top button
              Positioned(
                top: 0,
                left: sizeController.screenWidth * 0.48 / 3,
                right: sizeController.screenWidth * 0.48 / 3,
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
                      GamepadButton(
                        margin: const EdgeInsets.only(top: 4),
                        size: Size((sizeController.cellBoard + 24), (sizeController.cellBoard + 24)),
                      )
                    ],
                  ),
                ),
              ),
              //bottom button
              Positioned(
                bottom: 4,
                left: sizeController.screenWidth * 0.48 / 3,
                right: sizeController.screenWidth * 0.48 / 3,
                child: GestureDetector(
                  onTap: () => bottomButton(),
                  child: Column(
                    children: [
                      GamepadButton(
                        margin: const EdgeInsets.only(bottom: 4),
                        size: Size((sizeController.cellBoard + 24), (sizeController.cellBoard + 24)),
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
                top: sizeController.screenWidth * 0.5 / 2 - 3,
                left: sizeController.screenWidth * 0.5 / sizeController.gamepadButtonsFactor,
                right: sizeController.screenWidth * 0.5 / sizeController.gamepadButtonsFactor,
                child: Container(
                  height: 3,
                  color: const Color.fromARGB(255, 226, 231, 233),
                ),
              ),
              //left button
              Positioned(
                top: (sizeController.screenWidth * 0.42 + 20) / 3 + 4,
                left: 4,
                child: GestureDetector(
                  onTap: () => leftButton(),
                  child: Column(
                    children: [
                      GamepadButton(
                        margin: const EdgeInsets.only(bottom: 4),
                        size: Size((sizeController.cellBoard + 24), (sizeController.cellBoard + 24)),
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
                top: (sizeController.screenWidth * 0.42 + 20) / 3 + 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => rightButton(),
                  child: Column(
                    children: [
                      GamepadButton(
                        margin: const EdgeInsets.only(bottom: 4),
                        size: Size((sizeController.cellBoard + 24), (sizeController.cellBoard + 24)),
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
                top: (sizeController.screenWidth * 0.5) / 2 - 3,
                left: sizeController.screenWidth * 0.5 / sizeController.gamepadButtonsFactor,
                right: sizeController.screenWidth * 0.5 / sizeController.gamepadButtonsFactor,
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
        GestureDetector(
          onTapDown: (_) => rotateButtonDown(),
          onTapUp: (_) => rotateButtonUp(),
          child: Column(
            children: [
              GamepadButton(
                size: Size((sizeController.cellBoard + 55), (sizeController.cellBoard + 55)),
                margin: const EdgeInsets.symmetric(vertical: 8),
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
