import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

class Score extends PositionComponent with HasGameRef {
  int points = 0;
  final SpriteSheet _spriteSheet;

  Score({required SpriteSheet spritesheet})
      : _spriteSheet = spritesheet,
        super(
          anchor: Anchor.topCenter,
        );

  @override
  void render(Canvas canvas) {
    var temp = points;
    for (var d = 0; d < 6; d++) {
      final sprite = _spriteSheet.getSprite(0, temp % 10);
      sprite.render(
        canvas,
        position: Vector2(279.0 - 8 * d, 63.0),
        anchor: Anchor.topLeft,
      );
      temp = temp ~/ 10;
    }
  }
}
