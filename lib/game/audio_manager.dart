import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class AudioManager {
  AudioManager._internal();
  static AudioManager _instance = AudioManager._internal();
  static AudioManager get instance => _instance;
  Future<void> init(List<String> files) async {
    Flame.bgm.initialize();
    await Flame.audio.loadAll(files);
    _pref = await Hive.openBox('preferences');
    if (_pref.get('bgm') == null) {
      _pref.put('bgm', true);
    }
    if (_pref.get('sfx') == null) {
      _pref.put('sfx', true);
    }
    _sfx = ValueNotifier(_pref.get('sfx'));
    _bgm = ValueNotifier(_pref.get('bgm'));
  }

  Box _pref;
  ValueNotifier<bool> _sfx;
  ValueNotifier<bool> _bgm;
  ValueNotifier<bool> get listenablesfx => _sfx;
  ValueNotifier<bool> get listenablebgm => _bgm;

  void setSfx(bool flag) {
    _pref.put('sfx', flag);
    _sfx.value = flag;
  }

  void setBgm(bool flag) {
    _pref.put('bgm', flag);
    _bgm.value = flag;
  }

  void startBgm(String fileName) {
    if (_bgm.value) {
      Flame.bgm.play(
        fileName,
        volume: 0.4,
      );
    }
  }

  void pauseBgm() {
    if (_bgm.value) {
      Flame.bgm.pause();
    }
  }

  void resumeBgm() {
    if (_bgm.value) {
      Flame.bgm.resume();
    }
  }

  void stopBgm() {
    if (_bgm.value) {
      Flame.bgm.stop();
    }
  }

  void playSfx(String fileName) {
    if (_sfx.value) {
      Flame.audio.play(
        fileName,
      );
    }
  }
}
