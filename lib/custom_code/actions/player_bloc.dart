import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'player_event.dart';
import 'player_state.dart' as custom;
import 'audio_player_singleton.dart';

class PlayerBloc extends Bloc<PlayerEvent, custom.PlayerState> {
  final AudioPlayer audioPlayer = AudioPlayerSingleton().audioPlayer;
  final BaseAudioHandler baseAudioHandler = BaseAudioHandler();
  late ConcatenatingAudioSource _playlist;
  List<String> musicUrls;
  List<String> musicTitles = []; // Initialized to an empty list
  String initialUrl;
  String playlistImage;
  int currentTrackIndex = 0;
  double playbackSpeed = 1.0;

  PlayerBloc({
    required this.musicUrls,
    List<String>? titles,
    required this.initialUrl,
    required this.playlistImage,
  }) : super(custom.PlayerInitial()) {
    musicTitles = titles ?? []; // Ensure musicTitles is never null
    currentTrackIndex = musicUrls.indexOf(initialUrl);
    audioPlayer.positionStream.listen((event) {
      //this is to prevent miniplayer from being visble initially
      if (!audioPlayer.playing) {
        return;
      }
      emitChanges(musicUrls[currentTrackIndex], paused: !audioPlayer.playing);
    });
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _advanceToNextTrack();
      }
    });

    // Event handlers
    on<LoadTrack>(_onLoadTrack);
    on<PlayTrack>(_onPlayTrack);
    on<PauseTrack>(_onPauseTrack);
    on<StopTrack>(_onStopTrack);
    on<UpdatePosition>(_onUpdatePosition);
    on<ChangeTrack>(_onChangeTrack);
    on<SetPlaybackSpeed>(_onSetPlaybackSpeed);
    on<SkipForward>(_onSkipForward);
    on<SkipBackward>(_onSkipBackward);
    on<NextTrack>(_onNextTrack);
    on<PreviousTrack>(_onPreviousTrack);
    on<InitializePlayer>(
        _onInitializePlayer); // Added event handler for InitializePlayer
  }

  Future<void> _loadAndPlayTrack(String url) async {
    try {
      List<AudioSource> audio_source = [];
      int currentIndex = 0;
      for (int i = 0; i < musicUrls.length; i++) {
        if (url == musicUrls[i]) {
          currentIndex = i;
        }
        audio_source.add(AudioSource.uri(Uri.parse(musicUrls[i]),
            tag: MediaItem(
                id: musicUrls[i],
                title: musicTitles[i],
                artUri: Uri.parse(playlistImage))));
      }
      _playlist = ConcatenatingAudioSource(children: audio_source);
      await audioPlayer.setAudioSource(_playlist, initialIndex: currentIndex);
      currentTrackIndex = currentIndex;

      // emitChanges(musicUrls[currentIndex]);
    } catch (e) {
      print('Error loading or playing track: $e');
    }
  }

  // Event handler for InitializePlayer
  void _onInitializePlayer(
      InitializePlayer event, Emitter<custom.PlayerState> emit) {
    // Your logic to handle player initialization
    // Update the PlayerBloc's fields with the event's data
    this.initialUrl = event.initialUrl;
    this.musicUrls = event.musicUrls;
    this.musicTitles = event.musicTitles;
    this.playlistImage = event.playlistImage;
    // Any additional initialization logic
    _loadAndPlayTrack(event.initialUrl);
  }

  // // This function needs to emit states to reflect changes
  // void _updateMediaItemAndState(String url, {bool paused = false}) async {
  //   int index = musicUrls.indexOf(url);
  //   String title =
  //       index != -1 && index < musicTitles.length ? musicTitles[index] : '';
  //   MediaItem item =
  //       MediaItem(id: url, title: title, artUri: Uri.parse(playlistImage));
  //
  //   var source = AudioSource.uri(Uri.parse(url), tag: item);
  //   _playlist = ConcatenatingAudioSource(children: [source]);
  //   await audioPlayer.setAudioSource(source);
  //   currentTrackIndex=0;
  //
  //   if(!paused){
  //     await audioPlayer.play();
  //   }
  //
  //
  //   emitChanges(url,paused: paused);
  // }

  void emitChanges(String url, {bool paused = false}) {
    String title =
        musicTitles.isNotEmpty && currentTrackIndex < musicTitles.length
            ? musicTitles[currentTrackIndex]
            : 'Unknown Title'; // Use title based on currentTrackIndex

    emit(paused
        ? custom.PlayerPaused(
            currentTrack: title,
            trackImageUrl: playlistImage,
            position: audioPlayer.position,
            totalDuration: audioPlayer.duration ?? Duration.zero)
        : custom.PlayerPlaying(
            currentTrack: title,
            trackImageUrl: playlistImage,
            position: audioPlayer.position,
            totalDuration: audioPlayer.duration ?? Duration.zero));
  }

  //this can be used to load a particular track.
  void _onLoadTrack(LoadTrack event, Emitter<custom.PlayerState> emit) async {
    List<AudioSource> audio_source = [];
    int currentIndex = 0;
    for (int i = 0; i < musicUrls.length; i++) {
      if (event.url == musicUrls[i]) {
        currentIndex = i;
      }
      audio_source.add(AudioSource.uri(Uri.parse(musicUrls[i]),
          tag: MediaItem(
              id: musicUrls[i],
              title: musicTitles[i],
              artUri: Uri.parse(playlistImage))));
    }
    _playlist = ConcatenatingAudioSource(children: audio_source);
    await audioPlayer.setAudioSource(_playlist);
    currentTrackIndex = currentIndex;
  }

  void _onPlayTrack(PlayTrack event, Emitter<custom.PlayerState> emit) async {
    await audioPlayer.play();
    emitChanges(musicUrls[currentTrackIndex]);
  }

  void _onPauseTrack(PauseTrack event, Emitter<custom.PlayerState> emit) async {
    await audioPlayer.pause();
    emitChanges(musicUrls[currentTrackIndex], paused: true);
  }

  void _onStopTrack(StopTrack event, Emitter<custom.PlayerState> emit) async {
    await audioPlayer.stop();
    emit(custom.PlayerStopped());
  }

  void _onUpdatePosition(
      UpdatePosition event, Emitter<custom.PlayerState> emit) async {
    await audioPlayer.seek(event.position);

    emitChanges(musicUrls[currentTrackIndex]);
  }

  void _onChangeTrack(
      ChangeTrack event, Emitter<custom.PlayerState> emit) async {
    currentTrackIndex = musicUrls.indexOf(event.url);
    print("Track Changed ${event.url} ${currentTrackIndex}");

    await audioPlayer.seek(Duration.zero, index: currentTrackIndex);
    await audioPlayer.play();

    // Retrieve the title corresponding to the current track index
    String currentTitle =
        (currentTrackIndex >= 0 && currentTrackIndex < musicTitles.length)
            ? musicTitles[currentTrackIndex]
            : 'Unknown Title';

    // Emit changes with the correct title
    emitChanges(currentTitle);
  }

  void _onSetPlaybackSpeed(
      SetPlaybackSpeed event, Emitter<custom.PlayerState> emit) async {
    await audioPlayer.setSpeed(event.speed);
    playbackSpeed = event.speed;
    // _updateMediaItemAndState(musicUrls[currentTrackIndex]);

    emitChanges(musicUrls[currentTrackIndex], paused: !audioPlayer.playing);
  }

  void _onSkipForward(
      SkipForward event, Emitter<custom.PlayerState> emit) async {
    final newPosition = audioPlayer.position + Duration(seconds: event.seconds);

    await audioPlayer.seek(
        (newPosition.compareTo(audioPlayer.duration ?? Duration.zero)) > 0
            ? audioPlayer.duration ?? Duration.zero
            : newPosition);
    emitChanges(musicUrls[currentTrackIndex], paused: !audioPlayer.playing);
    // _updateMediaItemAndState(musicUrls[currentTrackIndex]);
  }

  void _onSkipBackward(
      SkipBackward event, Emitter<custom.PlayerState> emit) async {
    final newPosition = audioPlayer.position - Duration(seconds: event.seconds);

    await audioPlayer
        .seek((newPosition.isNegative) ? Duration.zero : newPosition);
    emitChanges(musicUrls[currentTrackIndex], paused: !audioPlayer.playing);
    // _updateMediaItemAndState(musicUrls[currentTrackIndex]);
  }

  void _onNextTrack(NextTrack event, Emitter<custom.PlayerState> emit) async {
    currentTrackIndex = (currentTrackIndex + 1) % musicUrls.length;
    String nextTrackUrl = musicUrls[currentTrackIndex];
    await audioPlayer.seek(Duration.zero, index: currentTrackIndex);
    await audioPlayer.play();
    emitChanges(nextTrackUrl);
  }

  void _onPreviousTrack(
      PreviousTrack event, Emitter<custom.PlayerState> emit) async {
    currentTrackIndex =
        currentTrackIndex > 0 ? currentTrackIndex - 1 : musicUrls.length - 1;
    String previousTrackUrl = musicUrls[currentTrackIndex];
    await audioPlayer.seek(Duration.zero, index: currentTrackIndex);
    await audioPlayer.play();
    emitChanges(previousTrackUrl);
  }

  void _advanceToNextTrack() {
    currentTrackIndex = (currentTrackIndex + 1) % musicUrls.length;
    String nextTrackUrl = musicUrls[currentTrackIndex];
    _loadAndPlayTrack(nextTrackUrl);
    emitChanges(nextTrackUrl);
  }
}
