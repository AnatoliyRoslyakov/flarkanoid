import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

class Brick extends Entity {
  static final Vector2 brickSize = Vector2(15, 7);

  Paint _paint;
  Paint _lightPaint;
  int _points;

  int get points => _points;

  Brick.silver({required Vector2 position})
      : this._(
          position: position,
          color: const Color(0xffc0c0c0),
          points: 150,
        );

  Brick.gold({required Vector2 position})
      : this._(
          position: position,
          color: const Color(0xfffdd700),
          points: 0,
        );

  Brick.red({required Vector2 position})
      : this._(
          position: position,
          color: Colors.red,
          points: 30,
        );

  Brick.yellow({required Vector2 position})
      : this._(
          position: position,
          color: const Color.fromARGB(255, 192, 192, 0),
          points: 130,
        );

  Brick.blue({required Vector2 position})
      : this._(
          position: position,
          color: const Color.fromARGB(255, 0, 0, 255),
          points: 110,
        );

  Brick.pink({required Vector2 position})
      : this._(
          position: position,
          color: const Color.fromARGB(255, 255, 0, 255),
          points: 10,
        );

  Brick.green({required Vector2 position})
      : this._(
          position: position,
          color: const Color.fromARGB(255, 0, 192, 0),
          points: 90,
        );

  Brick._({
    required Vector2 position,
    required Color color,
    required int points,
  })  : _paint = Paint()..color = color,
        _lightPaint = Paint()
          ..color = HSLColor.fromColor(color)
              .withLightness(
                (HSLColor.fromColor(color).lightness + .3).clamp(0.0, 1.0),
              )
              .toColor(),
        _points = points,
        super(
          position: position,
          size: brickSize,
          anchor: Anchor.topLeft,
          children: [
            RectangleHitbox(),
          ],
        );

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, brickSize.x, brickSize.y), _paint);
    canvas.drawRect(Rect.fromLTWH(0, 0, brickSize.x, 1), _lightPaint);
    canvas.drawRect(Rect.fromLTWH(0, 0, 1, brickSize.y), _lightPaint);
  }
}
