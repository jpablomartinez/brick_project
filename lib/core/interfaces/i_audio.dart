abstract class IAudio {
  Future<void> playBackgroundAudio(String source);
  Future<void> playSfx(String source);
  Future<void> pause();
  void mute();
}
