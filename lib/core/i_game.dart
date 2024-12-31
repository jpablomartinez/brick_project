abstract class IGame {
  double fps = 1 / 60;

  void startGame(Function frameUpdate);
  void update();
}
