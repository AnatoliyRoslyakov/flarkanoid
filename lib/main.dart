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

// Upgrade your flutter to latest version then delete android folder in your project then type flutter create . in terminal or cmd if you're using windows and done
