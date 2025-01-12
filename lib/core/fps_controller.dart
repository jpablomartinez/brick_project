class FpsController {
  int lastFrameTime = DateTime.now().millisecondsSinceEpoch;
  double fps = 0.0;

  void calculateFPS() {
    int currentFrameTime = DateTime.now().millisecondsSinceEpoch;
    int deltaTime = currentFrameTime - lastFrameTime;
    lastFrameTime = currentFrameTime;
    if (deltaTime > 0) {
      fps = (1000 / deltaTime);
    }
  }
}
