// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import '/custom_code/actions/audio_handler.dart';
import 'package:audio_service/audio_service.dart';

class QasasBackgroundPlayer extends StatefulWidget {
  const QasasBackgroundPlayer({
    Key? key,
    this.width,
    this.height,
    required this.initialUrl,
    required this.musicUrls,
    required this.musicTitles,
    required this.sliderActiveColor,
    required this.sliderInactiveColor,
    required this.backwardIconPath,
    required this.forwardIconPath,
    required this.backwardIconColor,
    required this.forwardIconColor,
    required this.pauseIconPath,
    required this.playIconPath,
    required this.pauseIconColor,
    required this.playIconColor,
    required this.playbackDurationTextColor,
    required this.previousIconPath,
    required this.nextIconPath,
    required this.previousIconColor,
    required this.nextIconColor,
    required this.dropdownTextColor,
    required this.timerIcon,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String initialUrl;
  final List<String> musicUrls;
  final List<String> musicTitles;
  final Color sliderActiveColor;
  final Color sliderInactiveColor;
  final Widget backwardIconPath;
  final Widget forwardIconPath;
  final Color backwardIconColor;
  final Color forwardIconColor;
  final Widget pauseIconPath;
  final Widget playIconPath;
  final Color pauseIconColor;
  final Color playIconColor;
  final Color playbackDurationTextColor;
  final Widget previousIconPath;
  final Widget nextIconPath;
  final Color previousIconColor;
  final Color nextIconColor;
  final Color dropdownTextColor;
  final Widget timerIcon;

  @override
  _QasasBackgroundPlayerState createState() => _QasasBackgroundPlayerState();
}

//GPT

//GPT

class _QasasBackgroundPlayerState extends State<QasasBackgroundPlayer>
    with SingleTickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  final _playlist = ConcatenatingAudioSource(children: []);
  bool isPlaying = true;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  int currentSongIndex = 0;
  bool isSpeakerOn = true;
  String playbackSpeed = '1.0x';
  Map<String, double> speedValues = {
    '0.5x': 0.5,
    '0.75x': 0.75,
    '1.0x': 1.0,
    '1.25x': 1.25,
    '1.5x': 1.5,
  };

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Duration? selectedTimer;
  final List<Duration> timerOptions = [
    Duration(minutes: 5),
    Duration(minutes: 10),
    Duration(minutes: 15),
    Duration(minutes: 20),
    Duration(minutes: 25),
    Duration(minutes: 30),
  ];
  Timer? countdownTimer;

  Future<void> _init() async {
    for (int i = 0; i < widget.musicUrls.length; i++) {
      String fileName = getFileNameFromUrl(widget.musicUrls[i]);
      _playlist.add(AudioSource.uri(
        Uri.parse(widget.musicUrls[i]),
        tag: MediaItem(id: "${i + 1}", title: fileName),
      ));
    }

    await audioPlayer.setAudioSource(_playlist);
  }

  String getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    List<String> pathSegments = path.split('/');
    String fileName = pathSegments.last;
    return fileName;
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _init();
    audioPlayer.playerStateStream.listen((PlayerState state) {
      setState(() {
        isPlaying = state.playing;
        totalDuration = audioPlayer.duration ?? Duration.zero;
        currentPosition = audioPlayer.position ?? Duration.zero;
      });

      if (state.processingState == ProcessingState.completed) {
        playNext();
      }

      // Update currentURL
      if (state.playing) {
        FFAppState().currentURL = widget.musicUrls[currentSongIndex];
        FFAppState().currentTitle = widget.musicTitles[currentSongIndex];
      }
    });
    audioPlayer.durationStream.listen((event) {
      if (event != null) {
        setState(() {
          totalDuration = event!;
        });
      }
    });
    audioPlayer.positionStream.listen((position) {
      setState(() {
        currentPosition = position;
      });
      // Check if the selected timer is complete
      if (selectedTimer != null && currentPosition >= selectedTimer!) {
        audioPlayer.pause();
        setState(() {
          selectedTimer = null;
        });
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _animationController.dispose();
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    super.dispose();
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  void updatePosition(double value) {
    final newPosition = Duration(milliseconds: value.toInt());
    seekTo(newPosition); // Complete the method call by passing newPosition
  }

  void playPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void skip(Duration duration) {
    final newPosition = currentPosition + duration;
    if (newPosition < Duration.zero) {
      seekTo(Duration.zero);
    } else if (newPosition > totalDuration) {
      seekTo(totalDuration);
    } else {
      seekTo(newPosition);
    }
  }

  void playPrevious() {
    audioPlayer.seekToPrevious();
    audioPlayer.play();
  }

  void playNext() {
    audioPlayer.seekToNext();
    audioPlayer.play();
  }

  void setPlaybackSpeed(String speed) {
    double playbackSpeed = speedValues[speed]!;
    audioPlayer.setSpeed(playbackSpeed);
  }

  void setTimer(Duration duration) {
    setState(() {
      selectedTimer = duration;
      if (duration == Duration.zero) {
        audioPlayer.pause(); // Pause the player if the selected timer is 0
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
              child: Text(
                'Kidea '
                '${currentSongIndex + 1}'
                ' de '
                '${widget.musicUrls.length}'
                ': '
                '${widget.musicTitles[currentSongIndex]}',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleMediumFamily,
                      fontSize: 16,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleMediumFamily),
                    ),
              ),
            ),
            Slider(
              value: currentPosition.inMilliseconds.toDouble(),
              min: 0,
              max: totalDuration.inMilliseconds.toDouble(),
              onChanged: (double value) {
                updatePosition(value);
              },
              activeColor: widget.sliderActiveColor,
              inactiveColor: widget.sliderInactiveColor,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: widget.playbackDurationTextColor),
                ),
                Text(
                  '${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: widget.playbackDurationTextColor),
                ),
              ],
            ),
            SizedBox(height: 8),
            //aquí empieza el play/pause back y forward
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.skip_previous_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30,
                  ),
                  onPressed: playPrevious,
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.replay_10,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30,
                  ),
                  onPressed: () => skip(Duration(seconds: -10)),
                ),
                /*
                IconButton(
                  iconSize: 65,
                  icon: isPlaying ? widget.pauseIconPath : widget.playIconPath,
                  color:
                      isPlaying ? widget.pauseIconColor : widget.playIconColor,
                  onPressed: playPause,
                ),
                */

                IconButton(
                  iconSize: 65,
                  icon: isPlaying ? widget.pauseIconPath : widget.playIconPath,
                  color:
                      isPlaying ? widget.pauseIconColor : widget.playIconColor,
                  onPressed: playPause,
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.forward_10,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30,
                  ),
                  onPressed: () => skip(Duration(seconds: 10)),
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.skip_next_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30,
                  ),
                  onPressed: playNext,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //inicia el timer
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Temporizador'),
                          content: Container(
                            height: 200,
                            width: 200,
                            child: ListView.builder(
                              itemCount: timerOptions.length,
                              itemBuilder: (BuildContext context, int index) {
                                final duration = timerOptions[index];
                                final minutes = duration.inMinutes;
                                bool isSelected = duration == selectedTimer;
                                return ListTile(
                                  title: Text(
                                    '$minutes minutos',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors
                                              .blue // Customize the selected option's text color
                                          : null,
                                    ),
                                  ),
                                  onTap: () {
                                    setTimer(
                                        duration); // Set the selected timer
                                  },
                                );
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedTimer = null;
                                  Navigator.pop(context);
                                });
                              },
                              child: Text('Cancelar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: widget.timerIcon,
                ),
                DropdownButton<String>(
                  value: playbackSpeed,
                  onChanged: (String? speed) {
                    setState(() {
                      playbackSpeed = speed!;
                      setPlaybackSpeed(speed);
                    });
                  },
                  items: speedValues.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: widget.dropdownTextColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
