import 'package:flame/components.dart';
import 'package:flappy_bird/components/bird_movement.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

class Bird extends SpriteGroupComponent<BirdMovment>
    with HasGameRef<FlappyBirdGame> {
  Bird();
  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);
    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2);
    current = BirdMovment.middle;
    sprites = {
      BirdMovment.middle: birdMidFlap,
      BirdMovment.up: birdUpFlap,
      BirdMovment.down: birdDownFlap,
    };
  }
}
