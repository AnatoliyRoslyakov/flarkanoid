import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

import 'behaviors/behaviors.dart';

class Paddle extends Entity {
  static final Vector2 paddleSize = Vector2(25, 6);

  Paddle._({
    required Sprite sprite,
    required Vector2 center,
    required Behavior movingBehavior,
  }) : super(
          position: center,
          size: paddleSize,
          anchor: Anchor.center,
          children: [
            SpriteComponent(
              sprite: sprite,
              size: paddleSize,
            ),
            //RectangleComponent.relative(
            //  Vector2.all(1),
            //  parentSize: paddleSize,
            //  paint: ArkanoidGame.paint,
            //),
            RectangleHitbox(),
          ],
          behaviors: [movingBehavior],
        );

  Paddle._withKeys({
    required Sprite sprite,
    required Vector2 center,
    required LogicalKeyboardKey leftKey,
    required LogicalKeyboardKey rightKey,
  }) : this._(
          sprite: sprite,
          center: center,
          movingBehavior: KeyboardMovingBehavior(
            leftKey: leftKey,
            rightKey: rightKey,
          ),
        );

  Paddle.arrows({
    required Sprite sprite,
    required Vector2 center,
  }) : this._withKeys(
          sprite: sprite,
          center: center,
          leftKey: LogicalKeyboardKey.arrowLeft,
          rightKey: LogicalKeyboardKey.arrowRight,
        );

  Paddle.wasd({
    required Sprite sprite,
    required Vector2 center,
  }) : this._withKeys(
          sprite: sprite,
          center: center,
          leftKey: LogicalKeyboardKey.keyA,
          rightKey: LogicalKeyboardKey.keyD,
        );
}
