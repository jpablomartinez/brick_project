import 'package:brick_project/widgets/gamepad_button.dart';
import 'package:flutter/material.dart';

class GamepadActions extends StatelessWidget {
  final Function soundHandler;
  final Function onOffHandler;
  final Function resetHandler;
  final Function pauseHandler;

  const GamepadActions({
    super.key,
    required this.soundHandler,
    required this.onOffHandler,
    required this.resetHandler,
    required this.pauseHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => soundHandler(),
          child: const Column(
            children: [
              GamepadButton(
                size: Size(35, 35),
                margin: EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              Text(
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
          child: const Column(
            children: [
              GamepadButton(
                size: Size(35, 35),
                margin: EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              Text(
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
          child: const Column(
            children: [
              GamepadButton(
                size: Size(35, 35),
                margin: EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              Text(
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
          child: const Column(
            children: [
              GamepadButton(
                size: Size(35, 35),
                margin: EdgeInsets.only(right: 12, left: 12, bottom: 4),
              ),
              Text(
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
