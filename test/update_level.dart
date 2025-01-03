import 'package:test/test.dart';

const raceCarGameLevel_1_2 = 20;
const raceCarGameLevel_3_4 = 30;
const raceCarGameLevel_5_6 = 40;
const raceCarGameLevel_7_8 = 50;
const raceCarGameLevel_9_10 = 60;

int level = 1;
int avoidedCars = 1;
int carsToAvoid = 0;
int speed = 0;

void updateLevel() {
  List<int> levels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> raceCarGameLevels = [raceCarGameLevel_1_2, raceCarGameLevel_3_4, raceCarGameLevel_5_6, raceCarGameLevel_7_8, raceCarGameLevel_9_10];
  for (int i = 0; i < levels.length - 1; i++) {
    if ((level == levels[i] || level == levels[i + 1]) && avoidedCars == raceCarGameLevels[(i / 2).floor()]) {
      carsToAvoid = level == levels[i + 1] ? raceCarGameLevels[((i / 2).floor()) + 1] : raceCarGameLevels[((i / 2).floor())];
      level++;
      speed++;
      break;
    }
  }
}

void main() {
  setUp(() {
    // Reset values before each test
    level = 1;
    avoidedCars = 1;
    carsToAvoid = 0;
    speed = 0;
  });

  test('Test Level 1, Avoided Cars raceCarGameLevel_1_2', () {
    level = 1;
    avoidedCars = raceCarGameLevel_1_2;

    updateLevel();

    expect(level, 2);
    expect(speed, 1);
    expect(carsToAvoid, raceCarGameLevel_1_2);
  });

  test('Test Level 3, Avoided Cars raceCarGameLevel_3_4', () {
    level = 3;
    avoidedCars = raceCarGameLevel_3_4;

    updateLevel();

    expect(level, 4);
    expect(speed, 1);
    expect(carsToAvoid, raceCarGameLevel_3_4);
  });

  test('Test Level 4, Avoided Cars raceCarGameLevel_3_4', () {
    level = 4;
    avoidedCars = raceCarGameLevel_3_4;

    updateLevel();

    expect(level, 5);
    expect(speed, 1);
    expect(carsToAvoid, raceCarGameLevel_5_6);
  });

  test('Test Level 5, Avoided Cars raceCarGameLevel_5_6', () {
    level = 5;
    avoidedCars = raceCarGameLevel_5_6;

    updateLevel();

    expect(level, 6);
    expect(carsToAvoid, raceCarGameLevel_5_6);
  });

  test('Test Level 9, Avoided Cars raceCarGameLevel_9_10', () {
    level = 9;
    avoidedCars = raceCarGameLevel_9_10;

    updateLevel();

    expect(level, 10); // No change
    expect(carsToAvoid, raceCarGameLevel_9_10); // No change
  });
}
