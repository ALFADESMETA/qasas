import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TracksRecord extends FirestoreRecord {
  TracksRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "like_count" field.
  int? _likeCount;
  int get likeCount => _likeCount ?? 0;
  bool hasLikeCount() => _likeCount != null;

  // "audioThumbnail" field.
  String? _audioThumbnail;
  String get audioThumbnail => _audioThumbnail ?? '';
  bool hasAudioThumbnail() => _audioThumbnail != null;

  // "favorite" field.
  List<DocumentReference>? _favorite;
  List<DocumentReference> get favorite => _favorite ?? const [];
  bool hasFavorite() => _favorite != null;

  // "is_feature" field.
  bool? _isFeature;
  bool get isFeature => _isFeature ?? false;
  bool hasIsFeature() => _isFeature != null;

  // "is_free" field.
  bool? _isFree;
  bool get isFree => _isFree ?? false;
  bool hasIsFree() => _isFree != null;

  // "publish_status" field.
  bool? _publishStatus;
  bool get publishStatus => _publishStatus ?? false;
  bool hasPublishStatus() => _publishStatus != null;

  // "category" field.
  List<String>? _category;
  List<String> get category => _category ?? const [];
  bool hasCategory() => _category != null;

  // "main_category" field.
  String? _mainCategory;
  String get mainCategory => _mainCategory ?? '';
  bool hasMainCategory() => _mainCategory != null;

  // "play_counter" field.
  int? _playCounter;
  int get playCounter => _playCounter ?? 0;
  bool hasPlayCounter() => _playCounter != null;

  // "track_user" field.
  DocumentReference? _trackUser;
  DocumentReference? get trackUser => _trackUser;
  bool hasTrackUser() => _trackUser != null;

  // "is_video" field.
  bool? _isVideo;
  bool get isVideo => _isVideo ?? false;
  bool hasIsVideo() => _isVideo != null;

  // "is_audio" field.
  bool? _isAudio;
  bool get isAudio => _isAudio ?? false;
  bool hasIsAudio() => _isAudio != null;

  // "age" field.
  String? _age;
  String get age => _age ?? '';
  bool hasAge() => _age != null;

  // "audioUrl" field.
  String? _audioUrl;
  String get audioUrl => _audioUrl ?? '';
  bool hasAudioUrl() => _audioUrl != null;

  // "audioUrlList" field.
  List<String>? _audioUrlList;
  List<String> get audioUrlList => _audioUrlList ?? const [];
  bool hasAudioUrlList() => _audioUrlList != null;

  // "track_id" field.
  String? _trackId;
  String get trackId => _trackId ?? '';
  bool hasTrackId() => _trackId != null;

  // "trackUrlList" field.
  List<String>? _trackUrlList;
  List<String> get trackUrlList => _trackUrlList ?? const [];
  bool hasTrackUrlList() => _trackUrlList != null;

  // "audioURL" field.
  String? _audioURL;
  String get audioURL => _audioURL ?? '';
  bool hasAudioURL() => _audioURL != null;

  // "audioUrlListX" field.
  List<String>? _audioUrlListX;
  List<String> get audioUrlListX => _audioUrlListX ?? const [];
  bool hasAudioUrlListX() => _audioUrlListX != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;
  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _likeCount = castToType<int>(snapshotData['like_count']);
    _audioThumbnail = snapshotData['audioThumbnail'] as String?;
    _favorite = getDataList(snapshotData['favorite']);
    _isFeature = snapshotData['is_feature'] as bool?;
    _isFree = snapshotData['is_free'] as bool?;
    _publishStatus = snapshotData['publish_status'] as bool?;
    _category = getDataList(snapshotData['category']);
    _mainCategory = snapshotData['main_category'] as String?;
    _playCounter = castToType<int>(snapshotData['play_counter']);
    _trackUser = snapshotData['track_user'] as DocumentReference?;
    _isVideo = snapshotData['is_video'] as bool?;
    _isAudio = snapshotData['is_audio'] as bool?;
    _age = snapshotData['age'] as String?;
    _audioUrl = snapshotData['audioUrl'] as String?;
    _audioUrlList = getDataList(snapshotData['audioUrlList']);
    _trackId = snapshotData['track_id'] as String?;
    _trackUrlList = getDataList(snapshotData['trackUrlList']);
    _audioURL = snapshotData['audioURL'] as String?;
    _audioUrlListX = getDataList(snapshotData['audioUrlListX']);
    _index = castToType<int>(snapshotData['index']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tracks');

  static Stream<TracksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TracksRecord.fromSnapshot(s));

  static Future<TracksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TracksRecord.fromSnapshot(s));

  static TracksRecord fromSnapshot(DocumentSnapshot snapshot) => TracksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TracksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TracksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TracksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TracksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTracksRecordData({
  String? title,
  String? description,
  DateTime? timestamp,
  int? likeCount,
  String? audioThumbnail,
  bool? isFeature,
  bool? isFree,
  bool? publishStatus,
  String? mainCategory,
  int? playCounter,
  DocumentReference? trackUser,
  bool? isVideo,
  bool? isAudio,
  String? age,
  String? audioUrl,
  String? trackId,
  String? audioURL,
  int? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'like_count': likeCount,
      'audioThumbnail': audioThumbnail,
      'is_feature': isFeature,
      'is_free': isFree,
      'publish_status': publishStatus,
      'main_category': mainCategory,
      'play_counter': playCounter,
      'track_user': trackUser,
      'is_video': isVideo,
      'is_audio': isAudio,
      'age': age,
      'audioUrl': audioUrl,
      'track_id': trackId,
      'audioURL': audioURL,
      'index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class TracksRecordDocumentEquality implements Equality<TracksRecord> {
  const TracksRecordDocumentEquality();

  @override
  bool equals(TracksRecord? e1, TracksRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.timestamp == e2?.timestamp &&
        e1?.likeCount == e2?.likeCount &&
        e1?.audioThumbnail == e2?.audioThumbnail &&
        listEquality.equals(e1?.favorite, e2?.favorite) &&
        e1?.isFeature == e2?.isFeature &&
        e1?.isFree == e2?.isFree &&
        e1?.publishStatus == e2?.publishStatus &&
        listEquality.equals(e1?.category, e2?.category) &&
        e1?.mainCategory == e2?.mainCategory &&
        e1?.playCounter == e2?.playCounter &&
        e1?.trackUser == e2?.trackUser &&
        e1?.isVideo == e2?.isVideo &&
        e1?.isAudio == e2?.isAudio &&
        e1?.age == e2?.age &&
        e1?.audioUrl == e2?.audioUrl &&
        listEquality.equals(e1?.audioUrlList, e2?.audioUrlList) &&
        e1?.trackId == e2?.trackId &&
        listEquality.equals(e1?.trackUrlList, e2?.trackUrlList) &&
        e1?.audioURL == e2?.audioURL &&
        listEquality.equals(e1?.audioUrlListX, e2?.audioUrlListX) &&
        e1?.index == e2?.index;
  }

  @override
  int hash(TracksRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.timestamp,
        e?.likeCount,
        e?.audioThumbnail,
        e?.favorite,
        e?.isFeature,
        e?.isFree,
        e?.publishStatus,
        e?.category,
        e?.mainCategory,
        e?.playCounter,
        e?.trackUser,
        e?.isVideo,
        e?.isAudio,
        e?.age,
        e?.audioUrl,
        e?.audioUrlList,
        e?.trackId,
        e?.trackUrlList,
        e?.audioURL,
        e?.audioUrlListX,
        e?.index

      ]);

  @override
  bool isValidKey(Object? o) => o is TracksRecord;
}
