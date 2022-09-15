import 'dart:math';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/components.dart';
import 'entities/entities.dart';

class ArkanoidGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  Score? score;
  Score? highScore;
  Score? round;
  SpriteComponent? scoreLabel;
  SpriteComponent? highScoreLabel;
  SpriteComponent? roundLabel;
  SpriteComponent? flutterLogo;

  int lives = 3;

  @override
  Color backgroundColor() => const Color(0xff202020);

  @override
  Future<void> onLoad() async {
    // Set the viewport size
    camera.viewport = FixedResolutionViewport(
      Vector2(320, 200),
    );

    final imagesLoader = Images();
    final paddleSprite = Sprite(
      await imagesLoader.load('paddle.png'),
    );
    final ballSprite = Sprite(
      await imagesLoader.load('ball.png'),
    );

    final paddleCenter = Vector2(
      Field.playFieldMargin + Field.borderWidth + Field.playFieldWidth / 2,
      size.y - 18 - Paddle.paddleSize.y / 2,
    );

    // -80 to +80 => (0 to 160) - 80
    // initial angle = 50 or 110
    final initialDirection = Random().nextBool();
    final positionOffset =
        30 * Paddle.paddleSize.x / 160.0 * (initialDirection ? 1 : -1);
    final ballCenter = Vector2.copy(paddleCenter)
      ..add(
        Vector2(
          positionOffset,
          -Paddle.paddleSize.y / 2 - Ball.ballSize.y / 2,
        ),
      );

    final ball = Ball(
      sprite: ballSprite,
      center: ballCenter,
      heading: (initialDirection ? 30 : -30) * degrees2Radians,
    );

    final fieldSprite = Sprite(
      await imagesLoader.load('field.png'),
    );

    final flarkanoidSprite = Sprite(
      await imagesLoader.load('flarkanoid.png'),
    );

    await addAll([
      RectangleComponent.fromRect(
        Rect.fromLTWH(
          0,
          0,
          camera.viewport.canvasSize!.x,
          camera.viewport.canvasSize!.y,
        ),
        paint: Paint()..color = Colors.black,
      ),
      Field(sprite: fieldSprite, size: Vector2(192.0, 200.0)),
      Paddle.arrows(
        sprite: paddleSprite,
        center: paddleCenter,
      ),
      ball,
      SpriteComponent(
        sprite: flarkanoidSprite,
        size: Vector2(108, 18),
        position: Vector2(259, 20),
        anchor: Anchor.topCenter,
      ),
      scoreLabel = SpriteComponent(
        sprite: Sprite(await imagesLoader.load('score.png')),
        size: Vector2(39, 8),
        position: Vector2(259, 52),
        anchor: Anchor.topCenter,
      ),
      score = Score(
        spritesheet: SpriteSheet(
          image: await imagesLoader.load('numbers.png'),
          srcSize: Vector2(8, 6),
        ),
        top: 63,
        length: 5,
        name: "Score",
      ),
      highScoreLabel = SpriteComponent(
        sprite: Sprite(await imagesLoader.load('high_score.png')),
        size: Vector2(72, 8),
        position: Vector2(259, 81),
        anchor: Anchor.topCenter,
      ),
      highScore = Score(
        spritesheet: SpriteSheet(
          image: await imagesLoader.load('numbers.png'),
          srcSize: Vector2(8, 6),
        ),
        top: 92,
        name: "High score",
      ),
      roundLabel = SpriteComponent(
        sprite: Sprite(await imagesLoader.load('round.png')),
        size: Vector2(39, 8),
        position: Vector2(259, 115),
        anchor: Anchor.topCenter,
      ),
      round = Score(
        spritesheet: SpriteSheet(
          image: await imagesLoader.load('numbers.png'),
          srcSize: Vector2(8, 6),
        ),
        top: 126,
        length: 1,
        name: "Round",
        points: 1,
      ),
      flutterLogo = SpriteComponent(
        sprite: Sprite(await imagesLoader.load('flutter.png')),
        size: Vector2(50, 62),
        scale: Vector2(.5, .5),
        position: Vector2(259, 158),
        anchor: Anchor.topCenter,
      ),
      SpriteComponent(
        sprite: paddleSprite,
        scale: Vector2(.5, .5),
        position: Vector2(20, 193),
        anchor: Anchor.topLeft,
      ),
      SpriteComponent(
        sprite: paddleSprite,
        scale: Vector2(.5, .5),
        position: Vector2(35, 193),
        anchor: Anchor.topLeft,
      )
      // Add a FPS counter if in debug mode.
      //if (kDebugMode)
      //  FpsTextComponent(
      //    position: Vector2(0, 0),
      //    anchor: Anchor.topLeft,
      //    textRenderer: TextPaint(
      //      style: const TextStyle(
      //        fontSize: Field.borderWidth,
      //        color: Colors.green,
      //      ),
      //    ),
      //  )
    ]);

    // Wait until everything is loaded
    await ready();

    await addAll([
      ...List.generate(
        11,
        (c) => Brick.silver(
          position: Vector2(
              1 + Field.playFieldMargin + Field.borderWidth + 16 * c,
              33.0 + 8 * 0),
        ),
      ),
      ...List.generate(
        11,
        (c) => Brick.red(
          position: Vector2(
              1 + Field.playFieldMargin + Field.borderWidth + 16 * c,
              33.0 + 8 * 1),
        ),
      ),
      ...List.generate(
        11,
        (c) => Brick.yellow(
          position: Vector2(
              1 + Field.playFieldMargin + Field.borderWidth + 16 * c,
              33.0 + 8 * 2),
        ),
      ),
      ...List.generate(
        11,
        (c) => Brick.blue(
          position: Vector2(
              1 + Field.playFieldMargin + Field.borderWidth + 16 * c,
              33.0 + 8 * 3),
        ),
      ),
      ...List.generate(
        11,
        (c) => Brick.pink(
          position: Vector2(
              1 + Field.playFieldMargin + Field.borderWidth + 16 * c,
              33.0 + 8 * 4),
        ),
      ),
      ...List.generate(
        11,
        (c) => Brick.green(
          position: Vector2(
              1 + Field.playFieldMargin + Field.borderWidth + 16 * c,
              33.0 + 8 * 5),
        ),
      ),
    ]);

    ball.reset();
  }

  @override
  @mustCallSuper
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    return KeyEventResult.handled;
  }

  void addPoints(int points) {
    score!.points += points;
    if (highScore!.points < score!.points) {
      highScore!.points = score!.points;
    }
  }
}
