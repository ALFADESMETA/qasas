import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class AgeRecord extends FirestoreRecord {
  AgeRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "age_name" field.
  String? _ageName;
  String get ageName => _ageName ?? '';
  bool hasAgeName() => _ageName != null;

  // "age_image" field.
  String? _ageImage;
  String get ageImage => _ageImage ?? '';
  bool hasAgeImage() => _ageImage != null;

  // "age_created_time" field.
  DateTime? _ageCreatedTime;
  DateTime? get ageCreatedTime => _ageCreatedTime;
  bool hasAgeCreatedTime() => _ageCreatedTime != null;

  // "age_id" field.
  String? _ageId;
  String get ageId => _ageId ?? '';
  bool hasAgeId() => _ageId != null;

  // "age_user" field.
  DocumentReference? _ageUser;
  DocumentReference? get ageUser => _ageUser;
  bool hasAgeUser() => _ageUser != null;

  void _initializeFields() {
    _ageName = snapshotData['age_name'] as String?;
    _ageImage = snapshotData['age_image'] as String?;
    _ageCreatedTime = snapshotData['age_created_time'] as DateTime?;
    _ageId = snapshotData['age_id'] as String?;
    _ageUser = snapshotData['age_user'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('age');

  static Stream<AgeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AgeRecord.fromSnapshot(s));

  static Future<AgeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AgeRecord.fromSnapshot(s));

  static AgeRecord fromSnapshot(DocumentSnapshot snapshot) => AgeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AgeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AgeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AgeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AgeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAgeRecordData({
  String? ageName,
  String? ageImage,
  DateTime? ageCreatedTime,
  String? ageId,
  DocumentReference? ageUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'age_name': ageName,
      'age_image': ageImage,
      'age_created_time': ageCreatedTime,
      'age_id': ageId,
      'age_user': ageUser,
    }.withoutNulls,
  );

  return firestoreData;
}

class AgeRecordDocumentEquality implements Equality<AgeRecord> {
  const AgeRecordDocumentEquality();

  @override
  bool equals(AgeRecord? e1, AgeRecord? e2) {
    return e1?.ageName == e2?.ageName &&
        e1?.ageImage == e2?.ageImage &&
        e1?.ageCreatedTime == e2?.ageCreatedTime &&
        e1?.ageId == e2?.ageId &&
        e1?.ageUser == e2?.ageUser;
  }

  @override
  int hash(AgeRecord? e) => const ListEquality()
      .hash([e?.ageName, e?.ageImage, e?.ageCreatedTime, e?.ageId, e?.ageUser]);

  @override
  bool isValidKey(Object? o) => o is AgeRecord;
}
