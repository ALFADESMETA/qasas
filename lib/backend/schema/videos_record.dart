import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VideosRecord extends FirestoreRecord {
  VideosRecord._(
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

  // "thumbnail" field.
  String? _thumbnail;
  String get thumbnail => _thumbnail ?? '';
  bool hasThumbnail() => _thumbnail != null;

  // "videoUrl" field.
  String? _videoUrl;
  String get videoUrl => _videoUrl ?? '';
  bool hasVideoUrl() => _videoUrl != null;

  // "postedBy" field.
  DocumentReference? _postedBy;
  DocumentReference? get postedBy => _postedBy;
  bool hasPostedBy() => _postedBy != null;

  // "views_counter" field.
  int? _viewsCounter;
  int get viewsCounter => _viewsCounter ?? 0;
  bool hasViewsCounter() => _viewsCounter != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _likeCount = castToType<int>(snapshotData['like_count']);
    _isFeature = snapshotData['is_feature'] as bool?;
    _isFree = snapshotData['is_free'] as bool?;
    _publishStatus = snapshotData['publish_status'] as bool?;
    _category = getDataList(snapshotData['category']);
    _mainCategory = snapshotData['main_category'] as String?;
    _thumbnail = snapshotData['thumbnail'] as String?;
    _videoUrl = snapshotData['videoUrl'] as String?;
    _postedBy = snapshotData['postedBy'] as DocumentReference?;
    _viewsCounter = castToType<int>(snapshotData['views_counter']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('videos');

  static Stream<VideosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VideosRecord.fromSnapshot(s));

  static Future<VideosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VideosRecord.fromSnapshot(s));

  static VideosRecord fromSnapshot(DocumentSnapshot snapshot) => VideosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VideosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VideosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VideosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VideosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVideosRecordData({
  String? title,
  String? description,
  DateTime? timestamp,
  int? likeCount,
  bool? isFeature,
  bool? isFree,
  bool? publishStatus,
  String? mainCategory,
  String? thumbnail,
  String? videoUrl,
  DocumentReference? postedBy,
  int? viewsCounter,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'like_count': likeCount,
      'is_feature': isFeature,
      'is_free': isFree,
      'publish_status': publishStatus,
      'main_category': mainCategory,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'postedBy': postedBy,
      'views_counter': viewsCounter,
    }.withoutNulls,
  );

  return firestoreData;
}

class VideosRecordDocumentEquality implements Equality<VideosRecord> {
  const VideosRecordDocumentEquality();

  @override
  bool equals(VideosRecord? e1, VideosRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.timestamp == e2?.timestamp &&
        e1?.likeCount == e2?.likeCount &&
        e1?.isFeature == e2?.isFeature &&
        e1?.isFree == e2?.isFree &&
        e1?.publishStatus == e2?.publishStatus &&
        listEquality.equals(e1?.category, e2?.category) &&
        e1?.mainCategory == e2?.mainCategory &&
        e1?.thumbnail == e2?.thumbnail &&
        e1?.videoUrl == e2?.videoUrl &&
        e1?.postedBy == e2?.postedBy &&
        e1?.viewsCounter == e2?.viewsCounter;
  }

  @override
  int hash(VideosRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.timestamp,
        e?.likeCount,
        e?.isFeature,
        e?.isFree,
        e?.publishStatus,
        e?.category,
        e?.mainCategory,
        e?.thumbnail,
        e?.videoUrl,
        e?.postedBy,
        e?.viewsCounter
      ]);

  @override
  bool isValidKey(Object? o) => o is VideosRecord;
}
