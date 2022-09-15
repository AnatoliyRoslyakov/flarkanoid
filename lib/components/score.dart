import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

class Score extends PositionComponent with HasGameRef {
  final SpriteSheet _spriteSheet;
  final double _top;
  final int _length;

  int points;

  Score({
    required SpriteSheet spritesheet,
    required double top,
    int length = 6,
    String name = 'unnamed',
    this.points = 0,
  })  : _spriteSheet = spritesheet,
        _top = top,
        _length = length,
        super(
          anchor: Anchor.topCenter,
        );

  @override
  void render(Canvas canvas) {
    var temp = points;
    for (var d = 0; d < _length; d++) {
      final sprite = _spriteSheet.getSprite(0, temp % 10);
      sprite.render(
        canvas,
        position: Vector2(260.0 + (_length - 1) * 4 - 8 * d, _top),
        anchor: Anchor.topCenter,
      );
      temp = temp ~/ 10;
    }
  }
}
