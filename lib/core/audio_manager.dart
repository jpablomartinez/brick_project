import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:brick_project/core/interfaces/i_audio.dart';
import 'package:logger/web.dart';

class AudioSettings implements IAudio {
  static final _logger = Logger();

  final double _defaultBackgroundVolume = 0.35;
  final double _reduceBackgroundVolume = 0.1;
  final double _defaultSfxVolume = 0.45;
  final double _defaultGamepadVolume = 0.4;

  final AudioPlayer _background = AudioPlayer();
  final AudioPlayer _sfx = AudioPlayer();
  final AudioPlayer _gamepad = AudioPlayer();

  late Queue _backgroundSongs;

  bool _audioOn = true;

  AudioSettings() {
    _background.setVolume(_defaultBackgroundVolume);
    _sfx.setVolume(_defaultSfxVolume);
    _gamepad.setVolume(_defaultGamepadVolume);
  }

  @override
  void addBackgroundSongs(List<String> songs) {
    if (songs.isEmpty) {
      return;
    }
    _backgroundSongs = Queue.of(songs);
    _background.onPlayerComplete.listen(_handleCompleteSong);
  }

  @override
  Future<void> playGamepad(String source) async {
    try {
      if (!_audioOn) {
        return;
      }
      await _gamepad.play(AssetSource(source));
    } catch (err) {
      _logger.e(err);
    }
  }

  @override
  Future<void> pause() async {
    _background.pause();
  }

  @override
  Future<void> playBackgroundAudio() async {
    try {
      if (!_audioOn || _backgroundSongs.isEmpty) {
        return;
      }
      await _background.play(AssetSource(_backgroundSongs.first));
    } catch (err) {
      _logger.e(err);
    }
  }

  Future<void> _handleCompleteSong(void_) async {
    _background.setVolume(_defaultBackgroundVolume);
    _backgroundSongs.add(_backgroundSongs.removeFirst());
    //a pause between songs
    await Future.delayed(const Duration(milliseconds: 500), () {
      playBackgroundAudio();
    });
  }

  @override
  Future<void> playSfx(String source) async {
    try {
      if (!_audioOn) {
        return;
      }
      if (_background.state == PlayerState.playing) {
        _background.setVolume(_reduceBackgroundVolume);
      }
      await _sfx.play(AssetSource(source));
      if (_sfx.state == PlayerState.completed && _background.state == PlayerState.playing) {
        _background.setVolume(_defaultBackgroundVolume);
      }
    } catch (err) {
      _logger.e(err);
    }
  }

  @override
  void mute() {
    _audioOn = !_audioOn;
    if (_background.state == PlayerState.playing) {
      _background.setVolume(_audioOn ? _defaultBackgroundVolume : 0);
    }
  }

  @override
  Future<void> preload() async {
    _logger.i('Preloading audios...');
    await AudioCache.instance.loadAll(
      [
        'audios/race/collision.wav',
        'audios/win_2.wav',
        'audios/game_over.mp3',
        'audios/race/start.wav',
      ],
    );
  }

  @override
  void setBackgroundVolume(int v) {
    _background.setVolume(v / 100);
  }

  @override
  void setSfxVolume(int v) {
    _sfx.setVolume(v / 100);
  }

  @override
  Future<void> stop() async {
    await _background.stop();
  }

  @override
  Future<void> resume() async {
    await _background.resume();
  }
}
