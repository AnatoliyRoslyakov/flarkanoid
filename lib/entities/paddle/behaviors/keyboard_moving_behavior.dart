import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flarkanoid/constants.dart';
import 'package:flutter/services.dart';

import '../../../components/components.dart';
import '../../entities.dart';

class KeyboardMovingBehavior extends Behavior<Paddle>
    with KeyboardHandler, HasGameRef {
  final LogicalKeyboardKey leftKey;
  final LogicalKeyboardKey rightKey;
  double _movement = 0; // 0 = no movement, -1 = left, 1 = right

  KeyboardMovingBehavior({
    required this.leftKey,
    required this.rightKey,
  });

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(leftKey)) {
      _movement = -1;
    } else if (keysPressed.contains(rightKey)) {
      _movement = 1;
    } else {
      _movement = 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
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
