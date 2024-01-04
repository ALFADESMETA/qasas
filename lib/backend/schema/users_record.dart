import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "is_admin" field.
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;
  bool hasIsAdmin() => _isAdmin != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "lastActive" field.
  DateTime? _lastActive;
  DateTime? get lastActive => _lastActive;
  bool hasLastActive() => _lastActive != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "allowPushNotification" field.
  bool? _allowPushNotification;
  bool get allowPushNotification => _allowPushNotification ?? false;
  bool hasAllowPushNotification() => _allowPushNotification != null;

  // "allowInAppNotification" field.
  bool? _allowInAppNotification;
  bool get allowInAppNotification => _allowInAppNotification ?? false;
  bool hasAllowInAppNotification() => _allowInAppNotification != null;

  // "allowEmailNotification" field.
  bool? _allowEmailNotification;
  bool get allowEmailNotification => _allowEmailNotification ?? false;
  bool hasAllowEmailNotification() => _allowEmailNotification != null;

  // "loggedIn" field.
  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;
  bool hasLoggedIn() => _loggedIn != null;

  // "subscribed" field.
  bool? _subscribed;
  bool get subscribed => _subscribed ?? false;
  bool hasSubscribed() => _subscribed != null;

  // "is_Editor" field.
  bool? _isEditor;
  bool get isEditor => _isEditor ?? false;
  bool hasIsEditor() => _isEditor != null;

  // "favorites" field.
  List<DocumentReference>? _favorites;
  List<DocumentReference> get favorites => _favorites ?? const [];
  bool hasFavorites() => _favorites != null;

  // "user_tracks" field.
  List<AudioPositionStruct>? _userTracks;
  List<AudioPositionStruct> get userTracks => _userTracks ?? const [];
  bool hasUserTracks() => _userTracks != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _isAdmin = snapshotData['is_admin'] as bool?;
    _password = snapshotData['password'] as String?;
    _lastActive = snapshotData['lastActive'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _allowPushNotification = snapshotData['allowPushNotification'] as bool?;
    _allowInAppNotification = snapshotData['allowInAppNotification'] as bool?;
    _allowEmailNotification = snapshotData['allowEmailNotification'] as bool?;
    _loggedIn = snapshotData['loggedIn'] as bool?;
    _subscribed = snapshotData['subscribed'] as bool?;
    _isEditor = snapshotData['is_Editor'] as bool?;
    _favorites = getDataList(snapshotData['favorites']);
    _userTracks = getStructList(
      snapshotData['user_tracks'],
      AudioPositionStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? isAdmin,
  String? password,
  DateTime? lastActive,
  String? status,
  bool? allowPushNotification,
  bool? allowInAppNotification,
  bool? allowEmailNotification,
  bool? loggedIn,
  bool? subscribed,
  bool? isEditor,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'is_admin': isAdmin,
      'password': password,
      'lastActive': lastActive,
      'status': status,
      'allowPushNotification': allowPushNotification,
      'allowInAppNotification': allowInAppNotification,
      'allowEmailNotification': allowEmailNotification,
      'loggedIn': loggedIn,
      'subscribed': subscribed,
      'is_Editor': isEditor,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.isAdmin == e2?.isAdmin &&
        e1?.password == e2?.password &&
        e1?.lastActive == e2?.lastActive &&
        e1?.status == e2?.status &&
        e1?.allowPushNotification == e2?.allowPushNotification &&
        e1?.allowInAppNotification == e2?.allowInAppNotification &&
        e1?.allowEmailNotification == e2?.allowEmailNotification &&
        e1?.loggedIn == e2?.loggedIn &&
        e1?.subscribed == e2?.subscribed &&
        e1?.isEditor == e2?.isEditor &&
        listEquality.equals(e1?.favorites, e2?.favorites) &&
        listEquality.equals(e1?.userTracks, e2?.userTracks);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.isAdmin,
        e?.password,
        e?.lastActive,
        e?.status,
        e?.allowPushNotification,
        e?.allowInAppNotification,
        e?.allowEmailNotification,
        e?.loggedIn,
        e?.subscribed,
        e?.isEditor,
        e?.favorites,
        e?.userTracks
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
