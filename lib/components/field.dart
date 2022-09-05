import 'package:flame/components.dart';

class Field extends SpriteComponent with HasGameRef {
  static const borderWidth = 8.0;
  static const playFieldWidth = 176.0;
  static const playFieldMargin = 6.0;

  Field({required super.sprite, required super.size})
      : super(
          position: Vector2(Field.playFieldMargin, 0.0),
        );
}
