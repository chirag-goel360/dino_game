import 'package:dino_run/game/enemy.dart';
import 'package:dino_run/game/enemy_manager.dart';
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

  DinoGame() {
    _parallaxComponent = ParallaxComponent(
      [
        ParallaxImage('parallax/plx-1.png'),
        ParallaxImage('parallax/plx-2.png'),
        ParallaxImage('parallax/plx-3.png'),
        ParallaxImage('parallax/plx-4.png'),
        ParallaxImage('parallax/plx-5.png'),
        ParallaxImage('parallax/plx-6.png',fill: LayerFill.none),
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
    _scoreText = TextComponent(score.toString(),config: TextConfig(
      fontFamily: 'Audiowide',
      color: Colors.white,
    ));
    add(_scoreText);
    addWidgetOverlay('hd',_buildhd());
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _scoreText.setByPosition(
      Position(((size.width/2)-(_scoreText.width/2)), 0),
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
    score += (60*t).toInt();
    _scoreText.text = score.toString();
    components.whereType<Enemy>().forEach((enemy) {
      if(_dino.distance(enemy)<30) {
        _dino.hit();
      }
    });
  }

  Widget _buildhd() {
    return IconButton(
      icon: Icon(
        Icons.pause,
        color: Colors.white,
        size: 30,
      ),
      onPressed: () {
        pauseGame();
      },
    );
  }

  void pauseGame() {
    pauseEngine();
    addWidgetOverlay('PauseMenu', _buildPauseMenu());
  }

  Widget _buildPauseMenu() {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Paused',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ), 
                onPressed: () {
                  resumeGame();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
  }
}