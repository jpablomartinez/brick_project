const double fps = 1 / 60;
const int row = 20;
const int columns = 10;

const int left = 3;
const int right = 6;

enum GameStates {
  start,
  play,
  pause,
  gameover,
  win,
  restartView,
  collision,
  menu,
  none,
}

const int maxLivesRace = 4;
const int maxLivesSnake = 1;
const int raceCarGameSecondsPerLevel_1 = 20;
const int raceCarGameSecondsPerLevel_2 = 45;
const int raceCarGameSecondsPerLevel_3 = 75;
const int raceCarGameSecondsPerLevel_4 = 110;
const int raceCarGameSecondsPerLevel_5 = 150;
const int raceCarGameSecondsPerLevel_6 = 195;
const int raceCarGameSecondsPerLevel_7 = 245;
const int raceCarGameSecondsPerLevel_8 = 300;
const int raceCarGameSecondsPerLevel_9 = 360;
const int raceCarGameSecondsPerLevel_10 = 430;
