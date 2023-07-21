// ignore_for_file: deprecated_member_use, non_constant_identifier_names, unused_local_variable

//creamos una clase para los sonidos
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class AppSounds {
  factory AppSounds() {
    return _singleton;
  }

  AppSounds._();

  static final AppSounds _singleton = AppSounds._();

  Future<void> errorSound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle
        .load("assets/sounds/error.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }

  Future<void> gameOverSound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle
        .load("assets/sounds/gameOver.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }

  Future<void> goodSound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle
        .load("assets/sounds/good.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }

  Future<void> startSound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle
        .load("assets/sounds/start.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }

  Future<void> successSound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle
        .load("assets/sounds/success.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }
  Future<void> helpSound() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle
        .load("assets/sounds/help.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }
}
