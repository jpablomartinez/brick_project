import 'package:logger/web.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class VibrateController {
  final _logger = Logger();

  Future<void> vibrate() async {
    bool canVibrate = await Vibration.hasVibrator();
    if (canVibrate) {
      Vibration.vibrate(duration: 50, preset: VibrationPreset.singleShortBuzz);
    } else {
      _logger.d('Device has not vibration support');
    }
  }
}
