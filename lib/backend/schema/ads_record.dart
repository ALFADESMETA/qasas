import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class AdsRecord extends FirestoreRecord {
  AdsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "ads_name" field.
  String? _adsName;
  String get adsName => _adsName ?? '';
  bool hasAdsName() => _adsName != null;

  // "ads_image" field.
  String? _adsImage;
  String get adsImage => _adsImage ?? '';
  bool hasAdsImage() => _adsImage != null;

  // "ads_url" field.
  String? _adsUrl;
  String get adsUrl => _adsUrl ?? '';
  bool hasAdsUrl() => _adsUrl != null;

  // "ads_active" field.
  bool? _adsActive;
  bool get adsActive => _adsActive ?? false;
  bool hasAdsActive() => _adsActive != null;

  // "ads_created_time" field.
  DateTime? _adsCreatedTime;
  DateTime? get adsCreatedTime => _adsCreatedTime;
  bool hasAdsCreatedTime() => _adsCreatedTime != null;

  // "ads_user" field.
  DocumentReference? _adsUser;
  DocumentReference? get adsUser => _adsUser;
  bool hasAdsUser() => _adsUser != null;

  void _initializeFields() {
    _adsName = snapshotData['ads_name'] as String?;
    _adsImage = snapshotData['ads_image'] as String?;
    _adsUrl = snapshotData['ads_url'] as String?;
    _adsActive = snapshotData['ads_active'] as bool?;
    _adsCreatedTime = snapshotData['ads_created_time'] as DateTime?;
    _adsUser = snapshotData['ads_user'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ads');

  static Stream<AdsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdsRecord.fromSnapshot(s));

  static Future<AdsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdsRecord.fromSnapshot(s));

  static AdsRecord fromSnapshot(DocumentSnapshot snapshot) => AdsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdsRecordData({
  String? adsName,
  String? adsImage,
  String? adsUrl,
  bool? adsActive,
  DateTime? adsCreatedTime,
  DocumentReference? adsUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'ads_name': adsName,
      'ads_image': adsImage,
      'ads_url': adsUrl,
      'ads_active': adsActive,
      'ads_created_time': adsCreatedTime,
      'ads_user': adsUser,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdsRecordDocumentEquality implements Equality<AdsRecord> {
  const AdsRecordDocumentEquality();

  @override
  bool equals(AdsRecord? e1, AdsRecord? e2) {
    return e1?.adsName == e2?.adsName &&
        e1?.adsImage == e2?.adsImage &&
        e1?.adsUrl == e2?.adsUrl &&
        e1?.adsActive == e2?.adsActive &&
        e1?.adsCreatedTime == e2?.adsCreatedTime &&
        e1?.adsUser == e2?.adsUser;
  }

  @override
  int hash(AdsRecord? e) => const ListEquality().hash([
        e?.adsName,
        e?.adsImage,
        e?.adsUrl,
        e?.adsActive,
        e?.adsCreatedTime,
        e?.adsUser
      ]);

  @override
  bool isValidKey(Object? o) => o is AdsRecord;
}
