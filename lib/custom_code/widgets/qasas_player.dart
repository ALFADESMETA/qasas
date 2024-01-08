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
    required this.sliderActiveColor,
    required this.sliderInactiveColor,
    required this.playIconPath, // Ensure this is defined
    required this.pauseIconPath, // Ensure this is defined
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color sliderActiveColor;
  final Color sliderInactiveColor;
  final Widget playIconPath; // Ensure this is a Widget
  final Widget pauseIconPath; // Ensure this is a Widget

  @override
  _QasasPlayerState createState() => _QasasPlayerState();
}

class _QasasPlayerState extends State<QasasPlayer> {
  late PlayerBloc playerBloc;
  late Map<String, double> speedValues;

  @override
  void initState() {
    super.initState();
    playerBloc = context.read<PlayerBloc>();
    speedValues = {
      '0.5x': 0.5,
      '1.0x': 1.0,
      '1.5x': 1.5,
      '2.0x': 2.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        bool isPlaying = state is PlayerPlaying;
        Duration currentPosition = state.position;
        Duration totalDuration = state.totalDuration;
        // print(currentPosition);

        return Container(
          width: widget.width,
          height: widget.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTrackProgressSlider(currentPosition, totalDuration),
              _buildPlaybackDuration(currentPosition, totalDuration),
              _buildPlayerControls(isPlaying),
              _buildSpeedControls(),
            ],
          ),
        );
      },
    );
  }

  Slider _buildTrackProgressSlider(
      Duration currentPosition, Duration totalDuration) {
    return Slider(
      value: currentPosition.inMilliseconds.toDouble() <=
              totalDuration.inMilliseconds.toDouble()
          ? currentPosition.inMilliseconds.toDouble()
          : 0,
      min: 0,
      max: totalDuration.inMilliseconds.toDouble(),
      onChanged: (value) {
        playerBloc.add(
            UpdatePosition(position: Duration(milliseconds: value.toInt())));
      },
      activeColor: widget.sliderActiveColor,
      inactiveColor: widget.sliderInactiveColor,
    );
  }

  Padding _buildPlaybackDuration(
      Duration currentPosition, Duration totalDuration) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_formatDuration(currentPosition)),
          Text(_formatDuration(totalDuration)),
        ],
      ),
    );
  }

  Row _buildPlayerControls(bool isPlaying) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: () => playerBloc.add(PreviousTrack()),
        ),
        IconButton(
          icon: const Icon(Icons.replay_10),
          onPressed: () => playerBloc.add(SkipBackward(seconds: 10)),
        ),
        IconButton(
          icon: isPlaying ? widget.pauseIconPath : widget.playIconPath,
          onPressed: () => _handlePlayPause(isPlaying),
        ),
        IconButton(
          icon: const Icon(Icons.forward_10),
          onPressed: () => playerBloc.add(SkipForward(seconds: 10)),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () => playerBloc.add(NextTrack()),
        ),
      ],
    );
  }

  void _handlePlayPause(bool isPlaying) {
    if (isPlaying) {
      playerBloc.add(PauseTrack());
    } else {
      playerBloc.add(PlayTrack(
        url: playerBloc.musicUrls[playerBloc.currentTrackIndex],
        imageUrl: playerBloc.playlistImage,
      ));
    }
  }

  Widget _buildSpeedControls() {
    String currentSpeed = speedValues.keys.firstWhere(
      (k) => speedValues[k] == playerBloc.playbackSpeed,
      orElse: () => '1.0x',
    );

    return DropdownButton<String>(
      value: currentSpeed,
      onChanged: (newSpeed) {
        currentSpeed = newSpeed.toString();
        _handleSpeedChange(newSpeed);
      },
      items: speedValues.keys.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _handleSpeedChange(String? newSpeed) {
    if (newSpeed != null) {
      playerBloc.add(SetPlaybackSpeed(speed: speedValues[newSpeed]!));
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
