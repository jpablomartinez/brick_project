import 'package:brick_project/colors.dart';
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

  final double gamepadWidth = 150;
  final double gamepadHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: gamepadWidth,
      height: gamepadHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: BrickProjectColors.black,
          width: 4,
        ),
      ),
      child: Stack(
        children: [
          //top button
          Positioned(
            top: 8,
            left: gamepadWidth / 3,
            child: GestureDetector(
              onTap: () => topButton(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BrickProjectColors.black,
                ),
              ),
            ),
          ),
          //bottom button
          Positioned(
            bottom: 8,
            left: gamepadWidth / 3,
            child: GestureDetector(
              onTap: () => bottomButton(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BrickProjectColors.black,
                ),
              ),
            ),
          ),
          //left button
          Positioned(
            top: gamepadHeight / 3,
            left: 8,
            child: GestureDetector(
              onTap: () => leftButton(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BrickProjectColors.black,
                ),
              ),
            ),
          ),
          //rigth button
          Positioned(
            top: gamepadHeight / 3,
            right: 8,
            child: GestureDetector(
              onTap: () => rightButton(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BrickProjectColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
