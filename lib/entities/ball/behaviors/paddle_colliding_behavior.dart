import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../entities.dart';

class PaddleCollidingBehavior extends CollisionBehavior<Paddle, Ball> {
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Paddle other) {
    if (!parent.isWaiting) {
      final ip = intersectionPoints.first;
      final ix =
          ip.x - other.position.x; // -(paddle width)/2 to (paddle width/2)
      final angle = (140 / Paddle.paddleSize.x * ix);
      parent.setHeading(angle * degrees2Radians);
    }
  }
}
