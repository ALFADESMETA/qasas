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
    String imageUrl = state.trackImageUrl;
    Duration currentPosition = state.position;
    Duration totalDuration = state.totalDuration;
    bool isPlaying = state is PlayerPlaying;

    return Container(
      key: ValueKey<String>(trackTitle), // Key to force rebuild on title change
      width: widget.width,
      height: widget.height,
      decoration: _playerDecoration(),
      child: Column(
        children: [
          _buildSlider(currentPosition, totalDuration, context),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                  onPressed: () {
                    if (isPlaying) {
                      context.read<PlayerBloc>().add(PauseTrack());
                    } else {
                      context
                          .read<PlayerBloc>()
                          .add(PlayTrack(url: trackTitle, imageUrl: imageUrl));
                    }
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                            child: Text(
                              trackTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  SliderTheme _buildSlider(
      Duration currentPosition, Duration totalDuration, BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
        activeTrackColor: Colors.green,
        inactiveTrackColor: Colors.grey[800],
      ),
      child: Slider(
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
      ),
    );
  }
}
