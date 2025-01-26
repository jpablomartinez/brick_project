import 'package:brick_project/core/size_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:flutter/material.dart';

class VersionApp extends StatelessWidget {
  final String versionApp = '0.2.1';
  final SizeController sizeController;
  const VersionApp({
    super.key,
    required this.sizeController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeController.screenWidth,
      height: sizeController.screenHeight * 0.05,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Text(
          'JK STUDIOS - Version $versionApp',
          style: const TextStyle(
            color: BrickProjectColors.black,
            fontFamily: 'Digital',
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
