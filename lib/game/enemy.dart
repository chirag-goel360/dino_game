import 'dart:math';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

enum EnemyType {
  AngryPig,
  Bat,
  Bee,
  BlueBird,
  Bunny,
  Chameleon,
  Chicken,
  Duck,
  FatBird,
  Ghost,
  Mushroom,
  Plant,
  Radish,
  Rino,
  Rocks,
  Skull,
  Slime,
  Snail,
  Trunk,
  Turtle
}

class EnemyData {
  final String imageName;
  final int textureWidth;
  final int textureHeight;
  final int nColumns;
  final int nRows;
  final bool canFly;
  final int speed;

  const EnemyData({
    @required this.imageName,
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.nColumns,
    @required this.nRows,
    @required this.canFly,
    @required this.speed,
  });
}

class Enemy extends AnimationComponent {
  EnemyData _myData;
  static Random _random = Random();

  static const Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.AngryPig: EnemyData(
      imageName: 'AngryPig/Walk (36x30).png',
      textureWidth: 36,
      textureHeight: 30,
      nColumns: 16,
      nRows: 1,
      canFly: false,
      speed: 250,
    ),
    EnemyType.Bat: EnemyData(
      imageName: 'Bat/Flying (46x30).png',
      textureWidth: 46,
      textureHeight: 30,
      nColumns: 7,
      nRows: 1,
      canFly: true,
      speed: 300,
    ),
    EnemyType.Bee: EnemyData(
      imageName: 'Bee/Idle (36x34).png',
      textureWidth: 36,
      textureHeight: 34,
      nColumns: 6,
      nRows: 1,
      canFly: true,
      speed: 300,
    ),
    EnemyType.BlueBird: EnemyData(
      imageName: 'BlueBird/Flying (32x32).png',
      textureWidth: 32,
      textureHeight: 32,
      nColumns: 9,
      nRows: 1,
      canFly: true,
      speed: 350,
    ),
    EnemyType.Bunny: EnemyData(
      imageName: 'Bunny/Run (34x44).png',
      textureWidth: 34,
      textureHeight: 44,
      nColumns: 12,
      nRows: 1,
      canFly: false,
      speed: 250,
    ),
    EnemyType.Chameleon: EnemyData(
      imageName: 'Chameleon/Run (84x38).png',
      textureWidth: 84,
      textureHeight: 38,
      nColumns: 8,
      nRows: 1,
      canFly: false,
      speed: 300,
    ),
    EnemyType.Chicken: EnemyData(
      imageName: 'Chicken/Run (32x34).png',
      textureWidth: 32,
      textureHeight: 34,
      nColumns: 14,
      nRows: 1,
      canFly: false,
      speed: 350,
    ),
    EnemyType.Duck: EnemyData(
      imageName: 'Duck/Idle (36x36).png',
      textureWidth: 36,
      textureHeight: 36,
      nColumns: 10,
      nRows: 1,
      canFly: false,
      speed: 250,
    ),
    EnemyType.FatBird: EnemyData(
      imageName: 'FatBird/Idle (40x48).png',
      textureWidth: 40,
      textureHeight: 48,
      nColumns: 8,
      nRows: 1,
      canFly: false,
      speed: 250,
    ),
    EnemyType.Ghost: EnemyData(
      imageName: 'Ghost/Idle (44x30).png',
      textureWidth: 44,
      textureHeight: 30,
      nColumns: 10,
      nRows: 1,
      canFly: false,
      speed: 350,
    ),
    EnemyType.Mushroom: EnemyData(
      imageName: 'Mushroom/Idle (32x32).png',
      textureWidth: 32,
      textureHeight: 32,
      nColumns: 14,
      nRows: 1,
      canFly: false,
      speed: 300,
    ),
    EnemyType.Plant: EnemyData(
      imageName: 'Plant/Idle (44x42).png',
      textureWidth: 44,
      textureHeight: 42,
      nColumns: 11,
      nRows: 1,
      canFly: false,
      speed: 300,
    ),
    EnemyType.Radish: EnemyData(
      imageName: 'Radish/Run (30x38).png',
      textureWidth: 30,
      textureHeight: 38,
      nColumns: 12,
      nRows: 1,
      canFly: false,
      speed: 350,
    ),
    EnemyType.Rino: EnemyData(
      imageName: 'Rino/Idle (52x34).png',
      textureWidth: 52,
      textureHeight: 34,
      nColumns: 11,
      nRows: 1,
      canFly: false,
      speed: 300,
    ),
    EnemyType.Rocks: EnemyData(
      imageName: 'Rocks/Rock1_Run (38x34).png',
      textureWidth: 38,
      textureHeight: 34,
      nColumns: 14,
      nRows: 1,
      canFly: false,
      speed: 200,
    ),
    EnemyType.Skull: EnemyData(
      imageName: 'Skull/Idle 2 (52x54).png',
      textureWidth: 52,
      textureHeight: 54,
      nColumns: 8,
      nRows: 1,
      canFly: false,
      speed: 300,
    ),
    EnemyType.Slime: EnemyData(
      imageName: 'Slime/Idle-Run (44x30).png',
      textureWidth: 44,
      textureHeight: 30,
      nColumns: 10,
      nRows: 1,
      canFly: false,
      speed: 200,
    ),
    EnemyType.Snail: EnemyData(
      imageName: 'Snail/Walk (38x24).png',
      textureWidth: 38,
      textureHeight: 24,
      nColumns: 10,
      nRows: 1,
      canFly: false,
      speed: 200,
    ),
    EnemyType.Trunk: EnemyData(
      imageName: 'Trunk/Attack (64x32).png',
      textureWidth: 64,
      textureHeight: 32,
      nColumns: 11,
      nRows: 1,
      canFly: false,
      speed: 250,
    ),
    EnemyType.Turtle: EnemyData(
      imageName: 'Turtle/Idle 1 (44x26).png',
      textureWidth: 44,
      textureHeight: 26,
      nColumns: 14,
      nRows: 1,
      canFly: false,
      speed: 250,
    ),
  };

  Enemy(EnemyType enemyType) : super.empty() {
    _myData = _enemyDetails[enemyType];
    final spriteSheet = SpriteSheet(
      imageName: _myData.imageName,
      textureWidth: _myData.textureWidth,
      textureHeight: _myData.textureHeight,
      columns: _myData.nColumns,
      rows: _myData.nRows,
    );
    this.animation = spriteSheet.createAnimation(
      0,
      from: 0,
      to: _myData.nColumns - 1,
      stepTime: 0.1,
    );
    this.anchor = Anchor.center;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    debugPrint(size.toString());
    double scaleFactor =
        (size.width / numberOfTilesAlongWidth) / _myData.textureWidth;
    this.height = _myData.textureHeight * scaleFactor;
    this.width = _myData.textureWidth * scaleFactor;
    this.x = size.width + this.width;
    this.y = size.height - groundHeight - (this.height / 2);
    if (_myData.canFly && _random.nextBool()) {
      this.y -= this.height;
    }
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= _myData.speed * t;
  }

  @override
  bool destroy() {
    return (this.x < (-this.width));
  }
}
