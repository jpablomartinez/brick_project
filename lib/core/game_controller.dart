import 'package:brick_project/core/audio_manager.dart';
import 'package:brick_project/core/fps_controller.dart';

class Game {
  String title;
  bool selected;

  Game(this.title, this.selected);

  void deselect() {
    selected = false;
  }

  void select() {
    selected = true;
  }
}

class GameController {
  late List<Game> games;
  late AudioSettings audioSettings;
  late FpsController fpsController;

  GameController(AudioSettings audio) {
    games = [
      Game('race', true),
      Game('snake', false),
      Game('tetris', false),
    ];
    audioSettings = audio;
  }
}
