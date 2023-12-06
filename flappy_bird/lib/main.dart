import 'package:flame/game.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

final game = FlappyBirdGame();
void main() {
  runApp(GameWidget(game: game));
}
