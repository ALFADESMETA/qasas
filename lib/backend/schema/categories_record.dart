import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CategoriesRecord extends FirestoreRecord {
  CategoriesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "cat_name" field.
  String? _catName;
  String get catName => _catName ?? '';
  bool hasCatName() => _catName != null;

  // "cat_image" field.
  String? _catImage;
  String get catImage => _catImage ?? '';
  bool hasCatImage() => _catImage != null;

  // "cat_created_time" field.
  DateTime? _catCreatedTime;
  DateTime? get catCreatedTime => _catCreatedTime;
  bool hasCatCreatedTime() => _catCreatedTime != null;

  // "cat_id" field.
  String? _catId;
  String get catId => _catId ?? '';
  bool hasCatId() => _catId != null;

  // "cat_user" field.
  DocumentReference? _catUser;
  DocumentReference? get catUser => _catUser;
  bool hasCatUser() => _catUser != null;

  // "views_counter" field.
  int? _viewsCounter;
  int get viewsCounter => _viewsCounter ?? 0;
  bool hasViewsCounter() => _viewsCounter != null;

  void _initializeFields() {
    _catName = snapshotData['cat_name'] as String?;
    _catImage = snapshotData['cat_image'] as String?;
    _catCreatedTime = snapshotData['cat_created_time'] as DateTime?;
    _catId = snapshotData['cat_id'] as String?;
    _catUser = snapshotData['cat_user'] as DocumentReference?;
    _viewsCounter = castToType<int>(snapshotData['views_counter']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('categories');

  static Stream<CategoriesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CategoriesRecord.fromSnapshot(s));

  static Future<CategoriesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CategoriesRecord.fromSnapshot(s));

  static CategoriesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CategoriesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CategoriesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CategoriesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CategoriesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CategoriesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCategoriesRecordData({
  String? catName,
  String? catImage,
  DateTime? catCreatedTime,
  String? catId,
  DocumentReference? catUser,
  int? viewsCounter,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'cat_name': catName,
      'cat_image': catImage,
      'cat_created_time': catCreatedTime,
      'cat_id': catId,
      'cat_user': catUser,
      'views_counter': viewsCounter,
    }.withoutNulls,
  );

  return firestoreData;
}

class CategoriesRecordDocumentEquality implements Equality<CategoriesRecord> {
  const CategoriesRecordDocumentEquality();

  @override
  bool equals(CategoriesRecord? e1, CategoriesRecord? e2) {
    return e1?.catName == e2?.catName &&
        e1?.catImage == e2?.catImage &&
        e1?.catCreatedTime == e2?.catCreatedTime &&
        e1?.catId == e2?.catId &&
        e1?.catUser == e2?.catUser &&
        e1?.viewsCounter == e2?.viewsCounter;
  }

  @override
  int hash(CategoriesRecord? e) => const ListEquality().hash([
        e?.catName,
        e?.catImage,
        e?.catCreatedTime,
        e?.catId,
        e?.catUser,
        e?.viewsCounter
      ]);

  @override
  bool isValidKey(Object? o) => o is CategoriesRecord;
}
