import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBtRXKnz8yGNb65naR9GZhdy1chDmLTKg0",
            authDomain: "qasasapp.firebaseapp.com",
            projectId: "qasasapp",
            storageBucket: "qasasapp.appspot.com",
            messagingSenderId: "127245806562",
            appId: "1:127245806562:web:e766a45019c95f0ea4a7bb",
            measurementId: "G-3BTXLHTGP7"));
  } else {
    await Firebase.initializeApp();
  }
}
