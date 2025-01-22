import 'package:flutter/material.dart';

import '../utils/colors.dart';

class GameSelector extends StatelessWidget {
  final String title;
  final bool selected;

  const GameSelector({
    super.key,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: BrickProjectColors.black.withOpacity(selected ? 0.2 : 0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 26,
          fontFamily: 'Digital',
          fontWeight: FontWeight.w700,
          color: BrickProjectColors.black,
        ),
      ),
    );
  }
}
