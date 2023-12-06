import 'dart:async';

import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pip_group.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flame/src/timer.dart' as time;

class FlappyBirdGame extends FlameGame {
  late Bird bird;
  time.Timer interval = time.Timer(Config.pipInterval, repeat: true);
  @override
  Future<void> onLoad() async {
    addAll([Background(), Ground(), bird = Bird(), PipGroup()]);
    interval.onTick = () => add(PipGroup());
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
  }
}
