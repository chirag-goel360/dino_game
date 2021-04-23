import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as animate;
import 'constants.dart';

class Dino extends AnimationComponent {
  animate.Animation _runAnimation;
  animate.Animation _hitAnimation;
  double speedY = 0.0;
  double yMax = 0.0;

  Dino() : super.empty() {
    // 0-3 = idle
    // 4-10 = run
    // 11-13 = kick
    // 14-16 = hit
    // 17-23 = sprint
    final spriteSheet = SpriteSheet(
      imageName: 'DinoSprites - tard.png', 
      textureWidth: 24, 
      textureHeight: 24, 
      columns: 24, 
      rows: 1,
    );
    //final idleAnimation = spriteSheet.createAnimation(0,from: 0,to: 3,stepTime: 0.1);
    _runAnimation = spriteSheet.createAnimation(0,from: 4,to: 10,stepTime: 0.1);
    _hitAnimation = spriteSheet.createAnimation(0,from: 14,to: 16,stepTime: 0.1);
    this.animation = _runAnimation;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    debugPrint(size.toString());
    this.height = this.width = size.width/numberOfTilesAlongWidth;
    this.x = this.width;
    this.y = size.height - groundHeight - this.height + dinoTopBottomSpacing;
    this.yMax = this.y;
  }

  @override
  void update(double t) {
    super.update(t);
    // v=u+at
    this.speedY += GRAVITY*t;
    // d=s+v*t
    this.y += this.speedY*t;
    if(isOnGround()) {
      this.y = this.yMax;
      this.speedY = 0.0;
    }
  }

  bool isOnGround() {
    return (this.y >= this.yMax);
  }

  void run() {
    this.animation = _runAnimation;
  }

  void hit() {
    this.animation = _hitAnimation;
  }

  void jump() {
    if(isOnGround()) {
      this.speedY = -600;
    }
  }
}