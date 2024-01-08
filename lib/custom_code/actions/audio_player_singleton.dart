import 'package:just_audio/just_audio.dart';

class AudioPlayerSingleton {
  // Private constructor for internal instantiation
  AudioPlayerSingleton._internal();

  // The single instance of AudioPlayer
  final AudioPlayer audioPlayer = AudioPlayer();

  // The factory constructor to access the singleton instance
  factory AudioPlayerSingleton() {
    return _instance;
  }

  // The static instance of the class, created only once
  static final AudioPlayerSingleton _instance =
      AudioPlayerSingleton._internal();
}
