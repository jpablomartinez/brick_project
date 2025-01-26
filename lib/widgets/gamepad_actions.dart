import 'package:brick_project/core/size_controller.dart';
import 'package:brick_project/widgets/gamepad_button.dart';
import 'package:flutter/material.dart';

class GamepadActions extends StatelessWidget {
  final Function soundHandler;
  final Function onOffHandler;
  final Function resetHandler;
  final Function pauseHandler;
  final SizeController sizeController;

  const GamepadActions({
    super.key,
    required this.soundHandler,
    required this.onOffHandler,
    required this.resetHandler,
    required this.pauseHandler,
    required this.sizeController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => soundHandler(),
          child: Column(
            children: [
              GamepadButton(
                size: Size((sizeController.cellBoard + 8), (sizeController.cellBoard + 8)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              const Text(
                'SOUND',
                style: TextStyle(
                  color: Color.fromARGB(255, 226, 231, 233),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => onOffHandler(),
          child: Column(
            children: [
              GamepadButton(
                size: Size((sizeController.cellBoard + 8), (sizeController.cellBoard + 8)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              const Text(
                'ON/OFF',
                style: TextStyle(
                  color: Color.fromARGB(255, 226, 231, 233),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => resetHandler(),
          child: Column(
            children: [
              GamepadButton(
                size: Size((sizeController.cellBoard + 8), (sizeController.cellBoard + 8)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              const Text(
                'RESET',
                style: TextStyle(
                  color: Color.fromARGB(255, 226, 231, 233),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => pauseHandler(),
          child: Column(
            children: [
              GamepadButton(
                size: Size((sizeController.cellBoard + 8), (sizeController.cellBoard + 8)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              const Text(
                'PAUSE',
                style: TextStyle(
                  color: Color.fromARGB(255, 226, 231, 233),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    );
  }
}
