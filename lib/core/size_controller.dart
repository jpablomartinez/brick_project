class SizeController {
  late double screenWidth;
  late double screenHeight;
  late double areaGameHeight;
  late double areaGameWidth;
  late double cellBoard;
  late double gamepadButtonsFactor;
  bool build = false;

  SizeController(double h, double w) {
    screenWidth = w;
    screenHeight = h;
    areaGameHeight = h * 0.57;
    areaGameWidth = h * 0.57 / 2;
    cellBoard = h * 0.57 / 2 / 10;
    gamepadButtonsFactor = h * 0.57 / 2 / 100;
    build = true;
  }
}
