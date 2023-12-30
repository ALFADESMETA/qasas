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

import 'package:flutter_bloc/flutter_bloc.dart';
import '/custom_code/actions/player_bloc.dart';
import '/custom_code/actions/player_event.dart';
import '/custom_code/actions/player_state.dart';

class QasasPlayer extends StatefulWidget {
  const QasasPlayer({
    Key? key,
    this.width,
    this.height,
    required this.initialUrl,
    required this.musicUrls,
    required this.musicTitles,
    required this.sliderActiveColor,
    required this.sliderInactiveColor,
    required this.playIconPath,
    required this.pauseIconPath,
    required this.playlistImage,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String initialUrl;
  final List<String> musicUrls;
  final List<String> musicTitles;
  final Color sliderActiveColor;
  final Color sliderInactiveColor;
  final Widget playIconPath;
  final Widget pauseIconPath;
  final String playlistImage;

  @override
  _QasasPlayerState createState() => _QasasPlayerState();
}

class _QasasPlayerState extends State<QasasPlayer> {
  late int currentSongIndex;
  late Map<String, double> speedValues;

  @override
  void initState() {
    super.initState();
    currentSongIndex = widget.musicUrls.indexOf(widget.initialUrl);
    speedValues = {
      '0.5x': 0.5,
      '1.0x': 1.0,
      '1.5x': 1.5,
      '2.0x': 2.0,
    };
    // Load the initial track
    context
        .read<PlayerBloc>()
        .add(LoadTrack(url: widget.initialUrl, imageUrl: widget.playlistImage));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerInitial) {
          return Center(child: CircularProgressIndicator());
        }

        bool isPlaying = state is PlayerPlaying;
        Duration currentPosition = state.position;
        Duration totalDuration = state.totalDuration;

        return Container(
          width: widget.width,
          height: widget.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Track Progress Slider
              Slider(
                value: currentPosition.inMilliseconds.toDouble(),
                min: 0,
                max: totalDuration.inMilliseconds.toDouble(),
                onChanged: (value) {
                  context.read<PlayerBloc>().add(UpdatePosition(
                      position: Duration(milliseconds: value.toInt())));
                },
                activeColor: widget.sliderActiveColor,
                inactiveColor: widget.sliderInactiveColor,
              ),
              // Playback Duration
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(currentPosition)),
                    Text(_formatDuration(totalDuration)),
                  ],
                ),
              ),
              // Player Controls
              _buildPlayerControls(context, isPlaying),
              // Speed Controls
              _buildSpeedControls(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayerControls(BuildContext context, bool isPlaying) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: () {
            context.read<PlayerBloc>().add(PreviousTrack());
          },
        ),
        IconButton(
          icon: Icon(Icons.replay_10),
          onPressed: () {
            context.read<PlayerBloc>().add(SkipBackward(seconds: 10));
          },
        ),
        IconButton(
          icon: isPlaying ? widget.pauseIconPath : widget.playIconPath,
          onPressed: () {
            if (isPlaying) {
              context.read<PlayerBloc>().add(PauseTrack());
            } else {
              int index = currentSongIndex % widget.musicUrls.length;
              context.read<PlayerBloc>().add(PlayTrack(
                  url: widget.musicUrls[index],
                  imageUrl: widget.playlistImage));
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.forward_10),
          onPressed: () {
            context.read<PlayerBloc>().add(SkipForward(seconds: 10));
          },
        ),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: () {
            context.read<PlayerBloc>().add(NextTrack());
          },
        ),
      ],
    );
  }

  Widget _buildSpeedControls(BuildContext context) {
    return DropdownButton<String>(
      value: speedValues.keys.firstWhere(
          (k) => speedValues[k] == context.read<PlayerBloc>().playbackSpeed,
          orElse: () => '1.0x'),
      onChanged: (String? newSpeed) {
        if (newSpeed != null) {
          context
              .read<PlayerBloc>()
              .add(SetPlaybackSpeed(speed: speedValues[newSpeed]!));
        }
      },
      items: speedValues.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
