import 'package:flutter/material.dart';

class Gamepad extends StatelessWidget {
  const Gamepad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      width: 160,
      height: 140,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 60,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 60,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
