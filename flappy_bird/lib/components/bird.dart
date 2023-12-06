import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flappy_bird/components/bird_movement.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/widgets.dart';

class Bird extends SpriteGroupComponent<BirdMovment>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
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
    add(CircleHitbox());
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
  }

  void gameOver() {
    gameRef.overlays.add('gameOver');

    gameRef.pauseEngine();
    game.isHit = true;
  }

  void fly() {
    add(MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(
          duration: 0.2,
          curve: Curves.decelerate,
        ),
        onComplete: () => current = BirdMovment.down));
    current = BirdMovment.up;
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2);
  }
}
