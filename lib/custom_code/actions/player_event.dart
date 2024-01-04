abstract class PlayerEvent {}

class LoadTrack extends PlayerEvent {
  final String url;
  final String imageUrl;

  LoadTrack({required this.url, required this.imageUrl});
}

class PlayTrack extends PlayerEvent {
  final String url;
  final String imageUrl;

  PlayTrack({required this.url, required this.imageUrl});
}

class PauseTrack extends PlayerEvent {}

class StopTrack extends PlayerEvent {}

class UpdatePosition extends PlayerEvent {
  final Duration position;

  UpdatePosition({required this.position});
}

class ChangeTrack extends PlayerEvent {
  final String url;

  ChangeTrack({required this.url});
}

class SetPlaybackSpeed extends PlayerEvent {
  final double speed;

  SetPlaybackSpeed({required this.speed});
}

class SkipForward extends PlayerEvent {
  final int seconds;

  SkipForward({required this.seconds});
}

class SkipBackward extends PlayerEvent {
  final int seconds;

  SkipBackward({required this.seconds});
}

class NextTrack extends PlayerEvent {}

class PreviousTrack extends PlayerEvent {}

class InitializePlayer extends PlayerEvent {
  final String initialUrl;
  final List<String> musicUrls;
  final List<String> musicTitles;
  final String playlistImage;

  InitializePlayer({
    required this.initialUrl,
    required this.musicUrls,
    required this.musicTitles,
    required this.playlistImage,
  });
}
