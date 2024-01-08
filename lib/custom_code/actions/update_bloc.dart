// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:provider/provider.dart';
import 'player_bloc.dart';
import 'player_event.dart';

Future<void> updateBloc(
  BuildContext context,
  String initialUrl,
  List<String> musicUrls,
  List<String> musicTitles,
  String playlistImage,
) async {
  final playerBloc = Provider.of<PlayerBloc>(context, listen: false);

  // Initialize the player with the new data
  playerBloc.add(InitializePlayer(
    initialUrl: initialUrl,
    musicUrls: musicUrls,
    musicTitles: musicTitles,
    playlistImage: playlistImage,
  ));

  // Play the initial track
  // playerBloc.add(LoadTrack(url: initialUrl, imageUrl: playlistImage));
  playerBloc.add(ChangeTrack(url: initialUrl));
}
