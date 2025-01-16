import 'package:audioplayers/audioplayers.dart';
import 'package:brick_project/core/interfaces/i_audio.dart';
import 'package:logger/web.dart';

class AudioSettings implements IAudio {
  static final _logger = Logger();

  final int _backgroundVolume = 50;
  final int _sfxVolume = 70;

  final AudioPlayer _background = AudioPlayer();
  final AudioPlayer _sfx = AudioPlayer();

  bool _audioOn = true;

  AudioSettings() {
    _background.setVolume(_backgroundVolume / 100);
    _sfx.setVolume(_sfxVolume / 100);
  }

  @override
  Future<void> pause() async {}

  @override
  Future<void> playBackgroundAudio(String source) async {
    try {
      if (!_audioOn) {
        return;
      }
      await _background.play(AssetSource(source));
    } catch (err) {
      _logger.e('CANNOT FIND AUDIO SOURCE');
    }
  }

  @override
  Future<void> playSfx(String source) async {
    try {
      if (!_audioOn) {
        return;
      }
      await _sfx.play(AssetSource(source));
    } catch (err) {
      _logger.e('CANNOT FIND AUDIO SOURCE');
    }
  }

  @override
  void mute() {
    _audioOn = !_audioOn;
  }
}
