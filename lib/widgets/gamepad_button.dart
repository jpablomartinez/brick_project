import 'package:brick_project/colors.dart';
import 'package:flutter/material.dart';

class GamepadButton extends StatelessWidget {
  final Size size;
  final EdgeInsetsGeometry margin;

  const GamepadButton({
    super.key,
    required this.size,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: BrickProjectColors.yellow,
        border: Border.all(
          color: BrickProjectColors.borderYellow,
          width: 3,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 16, 15, 15),
            offset: Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}
