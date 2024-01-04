import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _currentURL = prefs.getString('ff_currentURL') ?? _currentURL;
    });
    _safeInit(() {
      _currentTrackPosition =
          prefs.getDouble('ff_currentTrackPosition') ?? _currentTrackPosition;
    });
    _safeInit(() {
      _showMiniPlayer = prefs.getBool('ff_showMiniPlayer') ?? _showMiniPlayer;
    });
    _safeInit(() {
      _trackID = prefs.getString('ff_trackID') ?? _trackID;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _currentURL = '';
  String get currentURL => _currentURL;
  set currentURL(String value) {
    _currentURL = value;
    prefs.setString('ff_currentURL', value);
  }

  bool _playerState = false;
  bool get playerState => _playerState;
  set playerState(bool value) {
    _playerState = value;
  }

  bool _openAudio = false;
  bool get openAudio => _openAudio;
  set openAudio(bool value) {
    _openAudio = value;
  }

  double _currentTrackPosition = 0;
  double get currentTrackPosition => _currentTrackPosition;
  set currentTrackPosition(double value) {
    _currentTrackPosition = value;
    prefs.setDouble('ff_currentTrackPosition', value);
  }

  bool _showMiniPlayer = true;
  bool get showMiniPlayer => _showMiniPlayer;
  set showMiniPlayer(bool value) {
    _showMiniPlayer = value;
    prefs.setBool('ff_showMiniPlayer', value);
  }

  String _trackID = 'FCW7cLbwN55mUrN4OPuN';
  String get trackID => _trackID;
  set trackID(String value) {
    _trackID = value;
    prefs.setString('ff_trackID', value);
  }

  List<String> _trackList = [];
  List<String> get trackList => _trackList;
  set trackList(List<String> value) {
    _trackList = value;
  }

  void addToTrackList(String value) {
    _trackList.add(value);
  }

  void removeFromTrackList(String value) {
    _trackList.remove(value);
  }

  void removeAtIndexFromTrackList(int index) {
    _trackList.removeAt(index);
  }

  void updateTrackListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _trackList[index] = updateFn(_trackList[index]);
  }

  void insertAtIndexInTrackList(int index, String value) {
    _trackList.insert(index, value);
  }

  int _trackIndex = 0;
  int get trackIndex => _trackIndex;
  set trackIndex(int value) {
    _trackIndex = value;
  }

  int _currentTrackIndex = 0;
  int get currentTrackIndex => _currentTrackIndex;
  set currentTrackIndex(int value) {
    _currentTrackIndex = value;
  }

  String _currentTitle = '';
  String get currentTitle => _currentTitle;
  set currentTitle(String value) {
    _currentTitle = value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
