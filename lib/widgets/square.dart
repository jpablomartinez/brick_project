import 'package:brick_project/utils/colors.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final double height;
  final double width;

  const Square({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: BrickProjectColors.background,
          width: 1.5,
        ),
      ),
      child: Container(
        width: width - 2,
        height: height - 2,
        color: BrickProjectColors.black,
        child: Container(
          margin: const EdgeInsets.all(3.0),
          color: BrickProjectColors.background,
          child: Container(
            margin: const EdgeInsets.all(3.0),
            color: BrickProjectColors.black,
          ),
        ),
      ),
    );
  }
}

class BackgroundSquare extends StatelessWidget {
  final double height;
  final double width;

  const BackgroundSquare({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: BrickProjectColors.background,
          width: 1.5,
        ),
      ),
      child: Container(
        width: width - 2,
        height: height - 2,
        color: BrickProjectColors.black.withOpacity(0.04),
        child: Container(
          margin: const EdgeInsets.all(3.0),
          color: BrickProjectColors.background,
          child: Container(
            margin: const EdgeInsets.all(3.0),
            color: BrickProjectColors.black.withOpacity(0.04),
          ),
        ),
      ),
    );
  }
}
