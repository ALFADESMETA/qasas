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

import 'package:flutter_bloc/flutter_bloc.dart';
import '/custom_code/actions/player_bloc.dart';
import '/custom_code/actions/player_event.dart';
import '/custom_code/actions/player_state.dart';

class QasasMiniPlayer extends StatefulWidget {
  final double? width;
  final double? height;
  final Future<dynamic> Function() action;

  const QasasMiniPlayer({
    Key? key,
    this.width,
    this.height,
    required this.action,
  }) : super(key: key);

  @override
  _QasasMiniPlayerState createState() => _QasasMiniPlayerState();
}

class _QasasMiniPlayerState extends State<QasasMiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        bool isVisible = state is PlayerPlaying || state is PlayerPaused;
        double bottomOffset = isVisible ? 0 : -(widget.height ?? 0);

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: bottomOffset,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: widget.action,
            child: _buildPlayerContent(context, state),
          ),
        );
      },
    );
  }

  Widget _buildPlayerContent(BuildContext context, PlayerState state) {
    if (state is! PlayerPlaying && state is! PlayerPaused) {
      return const SizedBox.shrink();
    }

    String trackTitle = state.currentTrack;
    Duration currentPosition = state.position;
    Duration totalDuration = state.totalDuration;
    bool isPlaying = state is PlayerPlaying;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: _playerDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSlider(currentPosition, totalDuration, context),
          _buildControlRow(trackTitle, isPlaying, context),
        ],
      ),
    );
  }

  BoxDecoration _playerDecoration() {
    return BoxDecoration(
      color: Colors.black,
      boxShadow: const [
        BoxShadow(
          blurRadius: 4,
          color: Color(0x55000000),
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  Slider _buildSlider(
      Duration currentPosition, Duration totalDuration, BuildContext context) {
    return Slider(
      value: currentPosition.inSeconds.toDouble() <=
              totalDuration.inSeconds.toDouble()
          ? currentPosition.inSeconds.toDouble()
          : 0,
      min: 0,
      max: totalDuration.inSeconds.toDouble(),
      onChanged: (value) {
        context
            .read<PlayerBloc>()
            .add(UpdatePosition(position: Duration(seconds: value.toInt())));
      },
      activeColor: Colors.white,
      inactiveColor: Colors.grey[800],
    );
  }

  Padding _buildControlRow(
      String trackTitle, bool isPlaying, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              trackTitle,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            color: Colors.white,
            onPressed: () {
              if (isPlaying) {
                context.read<PlayerBloc>().add(PauseTrack());
              } else {
                // Ensure to provide the correct URL and Image URL for playing the track
                context.read<PlayerBloc>().add(PlayTrack(
                    url: trackTitle,
                    imageUrl: context.read<PlayerBloc>().playlistImage));
              }
            },
          ),
        ],
      ),
    );
  }
}
