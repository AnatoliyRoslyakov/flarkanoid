import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import 'behaviors/behaviors.dart';

class Ball extends Entity with HasGameRef {
  static final ballSize = Vector2.all(5);
  static const maxSpeed = 128.0;
  final velocity = Vector2.zero();

  double heading = 0.0;

  bool _waiting = true;

  bool get isWaiting => _waiting;

  Ball({
    required Sprite sprite,
    required Vector2 center,
    required double heading,
  }) : this._(
          sprite: sprite,
          center: center,
          heading: heading,
          behaviors: [
            BallInitialPositionBehavior(),
            MovingBehavior(),
            PaddleCollidingBehavior(),
            BrickCollidingBehavior(),
          ],
        );

  Ball._({
    required Sprite sprite,
    required Vector2 center,
    required this.heading,
    Vector2? startVelocity,
    Iterable<Behavior>? behaviors,
  }) : super(
          size: ballSize,
          position: center,
          anchor: Anchor.center,
          children: [
            SpriteComponent(
              sprite: sprite,
              size: ballSize,
            ),
          ],
          behaviors: [
            PropagatingCollisionBehavior(CircleHitbox()),
            if (behaviors != null) ...behaviors,
          ],
        ) {
    if (startVelocity != null) {
      velocity.setFrom(startVelocity);
    }
  }

  void reset() {
    setHeading(heading);
    _waiting = true;
  }

  void pause() {
    _waiting = true;
  }

  void shoot() {
    _waiting = false;
  }

  void setHeading(double angle) {
    heading = angle;
    velocity.setValues(
      sin(heading) * maxSpeed,
      -cos(heading) * maxSpeed,
    );
  }
}
