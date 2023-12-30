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
import 'package:just_audio/just_audio.dart';
import '/custom_code/actions/player_bloc.dart'; // Correct the import path as necessary
import '/custom_code/actions/player_event.dart';
import '/custom_code/actions/player_state.dart';

class QasasMiniPlayer extends StatefulWidget {
  const QasasMiniPlayer({
    Key? key,
    this.width,
    this.height,
    this.action,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function()? action;

  @override
  _QasasMiniPlayerState createState() => _QasasMiniPlayerState();
}

class _QasasMiniPlayerState extends State<QasasMiniPlayer> {
  @override
  Widget build(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);

    return BlocBuilder<PlayerBloc, PlayerState>(
      bloc: playerBloc,
      builder: (context, state) {
        if (state is PlayerInitial) {
          return SizedBox(); // Show nothing when player is not initialized
        }

        String trackTitle = '';
        String trackSubtitle = '';
        Duration currentPosition = Duration.zero;
        Duration totalDuration = Duration.zero;
        bool isPlaying = false;

        if (state is PlayerPlaying) {
          trackTitle = state.currentTrack;
          currentPosition = state.position;
          isPlaying = true;
          totalDuration = playerBloc.audioPlayer.duration ?? Duration.zero;
        } else if (state is PlayerPaused) {
          trackTitle = state.currentTrack;
          currentPosition = state.position;
          isPlaying = false;
          totalDuration = playerBloc.audioPlayer.duration ?? Duration.zero;
        }

        return GestureDetector(
          onTap: widget.action,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x55000000),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: currentPosition.inSeconds.toDouble(),
                  max: totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    final newPosition = Duration(seconds: value.toInt());
                    playerBloc.audioPlayer.seek(newPosition);
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey[800],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trackTitle,
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              trackSubtitle,
                              style: TextStyle(color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        color: Colors.white,
                        onPressed: () {
                          if (isPlaying) {
                            playerBloc.add(PauseTrack());
                          } else {
                            playerBloc.add(PlayTrack(url: trackTitle));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
