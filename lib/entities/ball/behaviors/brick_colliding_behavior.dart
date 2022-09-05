import 'package:arcanoid/arkanoid_game.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../entities.dart';

class BrickCollidingBehavior extends CollisionBehavior<Brick, Ball>
    with HasGameRef<ArkanoidGame> {
  BrickCollidingBehavior() : super();

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Brick other) {
    var brickIntersectionPoint = intersectionPoints.first - other.position;
    //debugPrint(brickIntersectionPoint.toString());
    if (brickIntersectionPoint.x == 0 && parent.velocity.x > 0) {
      // Hit the brick from the right side.
      //debugPrint("Hit from the right side");
      parent.velocity.x *= -1;
    } else if (brickIntersectionPoint.x == Brick.brickSize.x &&
        parent.velocity.x < 0) {
      // Hit the brick from the left side.
      //debugPrint("Hit from the left side");
      parent.velocity.x *= -1;
    } else if (brickIntersectionPoint.y == 0 && parent.velocity.y > 0) {
      // Hit the brick from the top side.
      //debugPrint("Hit from the top side");
      parent.velocity.y *= -1;
    } else if (brickIntersectionPoint.y == Brick.brickSize.y &&
        parent.velocity.y < 0) {
      // Hit the brick from the bottom side.
      //debugPrint("Hit from the bottom side");
      parent.velocity.y *= -1;
    }
    gameRef.score!.points += other.points;
    other.removeFromParent();
  }
}
