import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pip_group.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flame/src/timer.dart' as time;

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late TextComponent score;
  time.Timer interval = time.Timer(Config.pipInterval, repeat: true);
  bool isHit = false;
  @override
  Future<void> onLoad() async {
    addAll([Background(), Ground(), bird = Bird(), score = buildScore()]);
    interval.onTick = () => add(PipGroup());
  }

  TextComponent buildScore() {
    return TextBoxComponent(
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      text: 'Score: 0',
      textRenderer: TextPaint(),
    );
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }
}
