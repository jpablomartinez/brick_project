import 'package:brick_project/utils/colors.dart';
import 'package:flutter/material.dart';

class GamepadButton extends StatelessWidget {
  final Size size;
  final EdgeInsetsGeometry margin;
  final Widget icon;

  const GamepadButton({
    super.key,
    required this.size,
    required this.margin,
    this.icon = const SizedBox(),
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
      child: Center(
        child: icon,
      ),
    );
  }
}
