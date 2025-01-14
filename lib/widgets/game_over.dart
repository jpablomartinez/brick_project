import 'package:brick_project/utils/colors.dart';
import 'package:flutter/material.dart';

class GameOverWidget extends StatefulWidget {
  const GameOverWidget({super.key});

  @override
  State<GameOverWidget> createState() => _GameOverWidgetState();
}

class _GameOverWidgetState extends State<GameOverWidget> with SingleTickerProviderStateMixin {
  double opacity = 1.0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Listener para reiniciar la animación
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse(); // Reversa la animación
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward(); // Reanuda la animación hacia adelante
      }
    });

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(opacity: _animation.value, child: child);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'GAME OVER',
              style: TextStyle(
                color: BrickProjectColors.black,
                fontFamily: 'Digital',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Press Reset to continue',
              style: TextStyle(
                color: BrickProjectColors.black,
                //fontFamily: 'Digital',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
