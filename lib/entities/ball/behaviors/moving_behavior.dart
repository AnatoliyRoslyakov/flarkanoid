import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../components/components.dart';
import '../../entities.dart';

class MovingBehavior extends Behavior<Ball> with HasGameRef {
  @override
  void update(double dt) {
    if (!parent.isWaiting) {
      parent.position += parent.velocity * dt;
      final hitLeft = (parent.position.x <
          (parent.size.x / 2 + Field.borderWidth + Field.playFieldMargin));
      final hitRight = (parent.position.x >
          (Field.playFieldWidth +
              Field.borderWidth -
              parent.size.x / 2 +
              Field.playFieldMargin));
      final hitTop =
          (parent.position.y < (parent.size.y / 2 + Field.borderWidth));
      if (hitLeft || hitRight) {
        parent.velocity.x *= -1;
      }
      if (hitTop) {
        parent.velocity.y *= -1;
      }
      if (hitLeft) {
        parent.position.x =
            parent.size.x / 2 + Field.borderWidth + Field.playFieldMargin;
      }
      if (hitRight) {
        parent.position.x = Field.playFieldWidth +
            Field.borderWidth -
            parent.size.x / 2 +
            Field.playFieldMargin;
      }
      if (hitTop) {
        parent.position.y = parent.size.y / 2 + Field.borderWidth;
      }
    }
  }
}
