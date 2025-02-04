import 'package:brick_project/core/size_controller.dart';
import 'package:brick_project/utils/colors.dart';
import 'package:brick_project/utils/constants.dart';
import 'package:brick_project/widgets/gamepad_button.dart';
import 'package:flutter/material.dart';

class GamepadActions extends StatelessWidget {
  final Function resetHandler;
  final Function pauseHandler;
  final Function soundHandler;
  final Function onOffHandler;
  final GameStates gameStates;
  final SizeController sizeController;

  const GamepadActions({
    super.key,
    required this.resetHandler,
    required this.pauseHandler,
    required this.onOffHandler,
    required this.soundHandler,
    required this.gameStates,
    required this.sizeController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => soundHandler(),
              child: GamepadButton(
                size: Size((sizeController.cellBoard + 2), (sizeController.cellBoard + 2)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
                icon: const Icon(
                  Icons.music_note,
                  color: BrickProjectColors.yellowIcon,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onOffHandler(),
              child: GamepadButton(
                size: Size((sizeController.cellBoard + 2), (sizeController.cellBoard + 2)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
                icon: const Icon(
                  Icons.undo,
                  color: BrickProjectColors.yellowIcon,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => resetHandler(),
              child: GamepadButton(
                size: Size((sizeController.cellBoard + 2), (sizeController.cellBoard + 2)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
                icon: const Icon(
                  Icons.restart_alt,
                  color: BrickProjectColors.yellowIcon,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => pauseHandler(),
              child: GamepadButton(
                size: Size((sizeController.cellBoard + 2), (sizeController.cellBoard + 2)),
                margin: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
                icon: Icon(
                  gameStates == GameStates.play ? Icons.pause : Icons.play_arrow,
                  color: BrickProjectColors.yellowIcon,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
