abstract class IAudio {
  Future<void> playBackgroundAudio();
  Future<void> playSfx(String source);
  Future<void> playGamepad(String source);
  Future<void> pause();
  Future<void> stop();
  Future<void> resume();
  Future<void> preload();
  void setBackgroundVolume(int v);
  void setSfxVolume(int v);
  void addBackgroundSongs(List<String> songs);
  void mute();
}
