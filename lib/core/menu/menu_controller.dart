import 'dart:async';

import 'package:brick_project/core/audio_manager.dart';
import 'package:brick_project/core/interfaces/i_game.dart';

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

class MainMenuController extends IGame {
  late List<Game> games;
  late Timer frameTimer;
  late Function updateView;
  late AudioSettings audioSettings;

  void upButton() {
    audioSettings.playGamepad('audios/arrow_button.wav');
    int index = games.indexWhere((e) => e.selected == true);
    if (index > 0) {
      games[index].deselect();
      games[index - 1].select();
    }
  }

  void downButton() {
    audioSettings.playGamepad('audios/arrow_button.wav');
    int index = games.indexWhere((e) => e.selected == true);
    if (index < games.length - 1) {
      games[index].deselect();
      games[index + 1].select();
    }
  }

  void selectedButton() {
    audioSettings.playGamepad('audios/arrow_button.wav');
  }

  void updateFrame() {
    updateView();
  }

  @override
  void builder(Timer timer) {
    updateFrame();
  }

  @override
  bool checkGameOver() {
    return false;
  }

  @override
  void checkWin() {
    //
  }

  @override
  void pause() {
    //
  }

  @override
  void play() {
    //
  }

  @override
  void restart() {
    //
  }

  @override
  void setAudioSettings() {
    audioSettings = AudioSettings();
    audioSettings.addBackgroundSongs(['audios/background1.mp3', 'audios/background3.mp3']);
  }

  @override
  void startGame(Function frameUpdate) {
    games = [
      Game(' race', true),
      Game(' snake', false),
      Game(' tetris', false),
    ];
    setAudioSettings();
    audioSettings.playBackgroundAudio();
    updateView = frameUpdate;
    update();
  }

  @override
  void update() {
    frameTimer = Timer.periodic(Duration(milliseconds: (1000 * fps).floor()), (timer) {
      builder(timer);
    });
  }

  @override
  void updateLevel() {
    //
  }

  @override
  void updatePoints() {
    //
  }
}
