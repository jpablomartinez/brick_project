class FpsController {
  int lastFrameTime = DateTime.now().millisecondsSinceEpoch;
  double fps = 0.0;

  /// Calculates the frames per second (FPS) based on the time elapsed
  /// since the last frame. Updates the `fps` property with the current
  /// FPS value if the time difference is greater than zero.
  void calculateFPS() {
    int currentFrameTime = DateTime.now().millisecondsSinceEpoch;
    int deltaTime = currentFrameTime - lastFrameTime;
    lastFrameTime = currentFrameTime;
    if (deltaTime > 0) {
      fps = (1000 / deltaTime);
    }
  }
}
