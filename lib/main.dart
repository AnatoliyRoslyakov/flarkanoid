import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

import 'arkanoid_game.dart';

void main() {
  final game = ArkanoidGame();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}
