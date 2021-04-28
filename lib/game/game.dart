import 'package:dino_run/game/enemy.dart';
import 'package:dino_run/game/enemy_manager.dart';
import 'package:dino_run/widgets/game_over_menu.dart';
import 'package:dino_run/widgets/hd.dart';
import 'package:dino_run/widgets/pause_menu.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dino.dart';

class DinoGame extends BaseGame with TapDetector, HasWidgetsOverlay {
  Dino _dino;
  ParallaxComponent _parallaxComponent;
  TextComponent _scoreText;
  int score;
  EnemyManager _enemyManager;
  double _elapsedTime = 0.0;

  DinoGame() {
    _parallaxComponent = ParallaxComponent(
      [
        ParallaxImage(
          'parallax/plx-1.png',
        ),
        ParallaxImage(
          'parallax/plx-2.png',
        ),
        ParallaxImage(
          'parallax/plx-3.png',
        ),
        ParallaxImage(
          'parallax/plx-4.png',
        ),
        ParallaxImage(
          'parallax/plx-5.png',
        ),
        ParallaxImage(
          'parallax/plx-6.png',
          fill: LayerFill.none,
        ),
      ],
      baseSpeed: Offset(100,0),
      layerDelta: Offset(20,0),
    );
    add(_parallaxComponent);
    _dino = Dino();
    add(_dino);
    _enemyManager = EnemyManager();
    add(_enemyManager);
    score = 0;
    _scoreText = TextComponent(
      score.toString(),
      config: TextConfig(
        fontFamily: 'Audiowide',
        color: Colors.white,
      ),
    );
    add(_scoreText);
    addWidgetOverlay(
      'hd',
      HD(
        onPausePressed: pauseGame, 
        life: _dino.life,
      ),
    );
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _scoreText.setByPosition(
      Position(((size.width / 2) - (_scoreText.width / 2)), 0),
    );
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    _dino.jump();
  }

  @override
  void update(double t) {
    super.update(t);
    _elapsedTime += t;
    if(_elapsedTime > (1/60)) {
      _elapsedTime = 0.0;
      score += 1;
      _scoreText.text = score.toString();
    }
    components.whereType<Enemy>().forEach((enemy) {
      if(_dino.distance(enemy) < 30) {
        _dino.hit();
      }
    });
    if(_dino.life.value <= 0) {
      gameOver();
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        this.pauseGame();
        break;
      case AppLifecycleState.paused:
        this.pauseGame();
        break;
      case AppLifecycleState.detached:
        this.pauseGame();
        break;
    }
  }

  void pauseGame() {
    pauseEngine();
    addWidgetOverlay(
      'PauseMenu', 
      PauseMenu(
        onResumePressed: resumeGame,
      ),
    );
  }

  void resumeGame() {
    removeWidgetOverlay(
      'PauseMenu',
    );
    resumeEngine();
  }

  void gameOver() {
    pauseEngine();
    addWidgetOverlay(
      'GameOverMenu', 
      GameOverMenu(
        score: score, 
        onRestartPressed: reset,
      ),
    );
  }

  void reset() {
    this.score = 0;
    _dino.life.value = 5;
    _dino.run();
    _enemyManager.reset();
    components.whereType<Enemy>().forEach((enemy) {
      this.markToRemove(enemy);
    });
    removeWidgetOverlay(
      'GameOverMenu',
    );
    resumeEngine();
  }
}