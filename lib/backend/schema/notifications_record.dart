import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "userToBeNotified" field.
  DocumentReference? _userToBeNotified;
  DocumentReference? get userToBeNotified => _userToBeNotified;
  bool hasUserToBeNotified() => _userToBeNotified != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "sender" field.
  DocumentReference? _sender;
  DocumentReference? get sender => _sender;
  bool hasSender() => _sender != null;

  // "notificationType" field.
  String? _notificationType;
  String get notificationType => _notificationType ?? '';
  bool hasNotificationType() => _notificationType != null;

  // "notificationTitle" field.
  String? _notificationTitle;
  String get notificationTitle => _notificationTitle ?? '';
  bool hasNotificationTitle() => _notificationTitle != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "popup_image" field.
  String? _popupImage;
  String get popupImage => _popupImage ?? '';
  bool hasPopupImage() => _popupImage != null;

  void _initializeFields() {
    _createdTime = snapshotData['created_time'] as DateTime?;
    _userToBeNotified = snapshotData['userToBeNotified'] as DocumentReference?;
    _description = snapshotData['description'] as String?;
    _sender = snapshotData['sender'] as DocumentReference?;
    _notificationType = snapshotData['notificationType'] as String?;
    _notificationTitle = snapshotData['notificationTitle'] as String?;
    _isActive = snapshotData['is_active'] as bool?;
    _popupImage = snapshotData['popup_image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  DateTime? createdTime,
  DocumentReference? userToBeNotified,
  String? description,
  DocumentReference? sender,
  String? notificationType,
  String? notificationTitle,
  bool? isActive,
  String? popupImage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_time': createdTime,
      'userToBeNotified': userToBeNotified,
      'description': description,
      'sender': sender,
      'notificationType': notificationType,
      'notificationTitle': notificationTitle,
      'is_active': isActive,
      'popup_image': popupImage,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    return e1?.createdTime == e2?.createdTime &&
        e1?.userToBeNotified == e2?.userToBeNotified &&
        e1?.description == e2?.description &&
        e1?.sender == e2?.sender &&
        e1?.notificationType == e2?.notificationType &&
        e1?.notificationTitle == e2?.notificationTitle &&
        e1?.isActive == e2?.isActive &&
        e1?.popupImage == e2?.popupImage;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.createdTime,
        e?.userToBeNotified,
        e?.description,
        e?.sender,
        e?.notificationType,
        e?.notificationTitle,
        e?.isActive,
        e?.popupImage
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
