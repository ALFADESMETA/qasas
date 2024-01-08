abstract class PlayerState {
  final String currentTrack;
  final String trackImageUrl;
  final Duration position;
  final Duration totalDuration;

  PlayerState({
    required this.currentTrack,
    required this.trackImageUrl,
    required this.position,
    required this.totalDuration,
  });
}

class PlayerInitial extends PlayerState {
  PlayerInitial()
      : super(
          currentTrack: '',
          trackImageUrl: '',
          position: Duration.zero,
          totalDuration: Duration.zero,
        );
}

class PlayerPlaying extends PlayerState {
  PlayerPlaying({
    required String currentTrack,
    required String trackImageUrl,
    required Duration position,
    required Duration totalDuration,
  }) : super(
          currentTrack: currentTrack,
          trackImageUrl: trackImageUrl,
          position: position,
          totalDuration: totalDuration,
        );
}

class PlayerPaused extends PlayerState {
  PlayerPaused({
    required String currentTrack,
    required String trackImageUrl,
    required Duration position,
    required Duration totalDuration,
  }) : super(
          currentTrack: currentTrack,
          trackImageUrl: trackImageUrl,
          position: position,
          totalDuration: totalDuration,
        );
}

class PlayerStopped extends PlayerState {
  PlayerStopped()
      : super(
          currentTrack: '',
          trackImageUrl: '',
          position: Duration.zero,
          totalDuration: Duration.zero,
        );
}

class PlayerLoading extends PlayerState {
  PlayerLoading({
    required String currentTrack,
    required String trackImageUrl,
    required Duration position,
    required Duration totalDuration,
  }) : super(
          currentTrack: currentTrack,
          trackImageUrl: trackImageUrl,
          position: position,
          totalDuration: totalDuration,
        );
}
