import 'package:flutter/material.dart';
import 'package:brick_project/brick.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brick Game 3x',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        //fontFamilyFallback: const ['Digital', 'Roboto'],
      ),
      home: const BrickGames(),
    );
  }
}
