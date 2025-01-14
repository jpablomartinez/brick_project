import 'package:brick_project/games/race/models/car.dart';

import '../../../utils/constants.dart';

List<List<int>> firstExplosion = <List<int>>[
  <int>[1, 1, 1, 1, 1],
  <int>[1, 0, 0, 0, 1],
  <int>[1, 0, 0, 0, 1],
  <int>[1, 0, 0, 0, 1],
  <int>[1, 1, 1, 1, 1],
];
List<List<int>> secondExplosion = <List<int>>[
  <int>[1, 0, 1, 0, 1],
  <int>[0, 0, 0, 0, 0],
  <int>[1, 0, 0, 0, 1],
  <int>[0, 0, 0, 0, 0],
  <int>[1, 0, 1, 0, 1],
];
List<List<int>> thirdExplosion = <List<int>>[
  <int>[1, 0, 1, 0, 1],
  <int>[0, 1, 1, 1, 0],
  <int>[1, 1, 0, 1, 1],
  <int>[0, 1, 1, 1, 0],
  <int>[1, 0, 1, 0, 1],
];
List<List<int>> fourthExplosion = <List<int>>[
  <int>[0, 0, 0, 0, 0],
  <int>[0, 1, 1, 1, 0],
  <int>[0, 1, 0, 1, 0],
  <int>[0, 1, 1, 1, 0],
  <int>[0, 0, 0, 0, 0],
];
List<List<int>> fifthExplosion = <List<int>>[
  <int>[0, 0, 0, 0, 0],
  <int>[0, 0, 0, 0, 0],
  <int>[0, 0, 1, 0, 0],
  <int>[0, 0, 0, 0, 0],
  <int>[0, 0, 0, 0, 0],
];

class CollisionController {
  List<dynamic> collisions = [firstExplosion, secondExplosion, thirdExplosion, fourthExplosion, fifthExplosion];
  int collisionIt = 1;
  int explosionIt = 1;
  double collisionTime = 0;

  void restartCollisionTime() {
    collisionTime = 0;
  }

  void restartCollisionAnimation() {
    collisionIt = 1;
    explosionIt = 1;
  }

  /// Updates the game board to display the current frame of the collision animation.
  ///
  /// This method modifies the `board` to reflect the current state of the collision
  /// animation for the player's car. It uses the `collisions` list to determine
  /// the animation frame to display, based on the `collisionIt` index. The position
  /// on the board is determined by whether the player's car is in the left or right lane.
  ///
  /// The `collisionIt` index is incremented after updating the board to progress
  /// to the next frame in subsequent calls.
  ///
  /// - Parameters:
  ///   - board: A 2D list representing the game board where the animation is displayed.
  ///   - player: The player's car object, used to determine the lane position.
  void collisionAnimation(List<List<int>> board, Car player) {
    List<List<int>> tmp = collisions[collisionIt - 1];
    int col = player.leftLane ? left : right;
    for (int i = 14, k = 0; k < 5; i++, k++) {
      for (int j = -2; j < 3; j++) {
        board[i][col + j] = tmp[k][j + 2];
      }
    }
    collisionIt++;
  }

  void restartCollisionAnimationFrame() {
    collisionIt = 1;
    explosionIt = 2;
  }

  bool isCollisionTimeComplete() {
    return collisionTime > 80;
  }

  bool isCollisionAnimatioFrameEnd() {
    return (explosionIt == 1 && collisionIt == 6);
  }

  bool isCollisionAnimationComplete() {
    return explosionIt == 2 && collisionIt == 6;
  }
}
