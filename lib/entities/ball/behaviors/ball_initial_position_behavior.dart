import 'package:arcanoid/constants.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

import '../../../components/components.dart';
import '../../entities.dart';

class BallInitialPositionBehavior extends Behavior<Ball>
    with KeyboardHandler, HasGameRef {
  double _movement = 0; // 0 = no movement, -1 = left, 1 = right

  BallInitialPositionBehavior();

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (parent.isWaiting) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        _movement = -1;
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        _movement = 1;
      } else {
        _movement = 0;
      }

      if (keysPressed.contains(LogicalKeyboardKey.space)) {
        parent.shoot();
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    if (parent.isWaiting) {
      parent.position.x += _movement * kPaddleSpeed * dt;

      parent.position.x = parent.position.x.clamp(
        Field.playFieldMargin + parent.size.x / 2 + Field.borderWidth,
        Field.playFieldMargin +
            Field.playFieldWidth +
            Field.borderWidth -
            parent.size.x / 2,
      );
    }
  }
}
