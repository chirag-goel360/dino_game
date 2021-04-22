import 'package:flame/components/animation_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/spritesheet.dart';

class DinoGame extends BaseGame{
  AnimationComponent _dino;

  DinoGame(){
    _dino = AnimationComponent.empty();
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
    final idleAnimation = spriteSheet.createAnimation(0,from: 0,to: 3,stepTime: 0.1);
    final runAnimation = spriteSheet.createAnimation(0,from: 4,to: 10,stepTime: 0.1);
    _dino.animation = runAnimation;
    _dino.height = 80;
    _dino.width = 80;
    _dino.x = 80;
    _dino.y = 200;
    add(_dino);
  }  
}