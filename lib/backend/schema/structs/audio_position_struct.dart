// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AudioPositionStruct extends FFFirebaseStruct {
  AudioPositionStruct({
    String? trackId,
    double? trackPosition,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _trackId = trackId,
        _trackPosition = trackPosition,
        super(firestoreUtilData);

  // "track_id" field.
  String? _trackId;
  String get trackId => _trackId ?? '';
  set trackId(String? val) => _trackId = val;
  bool hasTrackId() => _trackId != null;

  // "track_position" field.
  double? _trackPosition;
  double get trackPosition => _trackPosition ?? .0;
  set trackPosition(double? val) => _trackPosition = val;
  void incrementTrackPosition(double amount) =>
      _trackPosition = trackPosition + amount;
  bool hasTrackPosition() => _trackPosition != null;

  static AudioPositionStruct fromMap(Map<String, dynamic> data) =>
      AudioPositionStruct(
        trackId: data['track_id'] as String?,
        trackPosition: castToType<double>(data['track_position']),
      );

  static AudioPositionStruct? maybeFromMap(dynamic data) => data is Map
      ? AudioPositionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'track_id': _trackId,
        'track_position': _trackPosition,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'track_id': serializeParam(
          _trackId,
          ParamType.String,
        ),
        'track_position': serializeParam(
          _trackPosition,
          ParamType.double,
        ),
      }.withoutNulls;

  static AudioPositionStruct fromSerializableMap(Map<String, dynamic> data) =>
      AudioPositionStruct(
        trackId: deserializeParam(
          data['track_id'],
          ParamType.String,
          false,
        ),
        trackPosition: deserializeParam(
          data['track_position'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'AudioPositionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AudioPositionStruct &&
        trackId == other.trackId &&
        trackPosition == other.trackPosition;
  }

  @override
  int get hashCode => const ListEquality().hash([trackId, trackPosition]);
}

AudioPositionStruct createAudioPositionStruct({
  String? trackId,
  double? trackPosition,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AudioPositionStruct(
      trackId: trackId,
      trackPosition: trackPosition,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AudioPositionStruct? updateAudioPositionStruct(
  AudioPositionStruct? audioPosition, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    audioPosition
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAudioPositionStructData(
  Map<String, dynamic> firestoreData,
  AudioPositionStruct? audioPosition,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (audioPosition == null) {
    return;
  }
  if (audioPosition.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && audioPosition.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final audioPositionData =
      getAudioPositionFirestoreData(audioPosition, forFieldValue);
  final nestedData =
      audioPositionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = audioPosition.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAudioPositionFirestoreData(
  AudioPositionStruct? audioPosition, [
  bool forFieldValue = false,
]) {
  if (audioPosition == null) {
    return {};
  }
  final firestoreData = mapToFirestore(audioPosition.toMap());

  // Add any Firestore field values
  audioPosition.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAudioPositionListFirestoreData(
  List<AudioPositionStruct>? audioPositions,
) =>
    audioPositions
        ?.map((e) => getAudioPositionFirestoreData(e, true))
        .toList() ??
    [];
