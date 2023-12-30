// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:just_audio/just_audio.dart';
import 'dart:async';
import '/custom_code/qasas_player.dart'; // Assuming QasasPlayer is in the 'widgets' directory

class MiniPlayer extends StatefulWidget {
  final Color sliderActiveColor;
  final Color sliderInactiveColor;
  final Widget playIconPath;
  final Color playIconColor;
  final Widget pauseIconPath;
  final Color pauseIconColor;
  final Color backgroundColor;
  final double? width;
  final double? height;

  const MiniPlayer({
    Key? key,
    required this.sliderActiveColor,
    required this.sliderInactiveColor,
    required this.playIconPath,
    required this.playIconColor,
    required this.pauseIconPath,
    required this.pauseIconColor,
    required this.backgroundColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  late AudioPlayer audioPlayer;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    // Assuming QasasPlayer uses a singleton pattern for AudioPlayer
    audioPlayer = AudioPlayerSingleton().audioPlayer;

    audioPlayer.positionStream.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    audioPlayer.durationStream.listen((duration) {
      setState(() {
        totalDuration = duration ?? Duration.zero;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0), // Adjust the padding
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(20), // Adjust the border radius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Slider(
                  value: currentPosition.inMilliseconds.toDouble(),
                  min: 0,
                  max: totalDuration.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    audioPlayer.seek(Duration(milliseconds: value.toInt()));
                  },
                  activeColor: widget.sliderActiveColor,
                  inactiveColor: widget.sliderInactiveColor,
                ),
              ),
              IconButton(
                icon: audioPlayer.playing
                    ? widget.pauseIconPath
                    : widget.playIconPath,
                color: audioPlayer.playing
                    ? widget.pauseIconColor
                    : widget.playIconColor,
                onPressed: () {
                  if (audioPlayer.playing) {
                    audioPlayer.pause();
                  } else {
                    audioPlayer.play();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
