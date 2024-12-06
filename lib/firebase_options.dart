// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYb45izHOd7bLeNjaLULLZKjBkwZZ6mFE',
    appId: '1:771248560614:web:12273410d5cdee68981e27',
    messagingSenderId: '771248560614',
    projectId: 'todocredit-8e731',
    authDomain: 'todocredit-8e731.firebaseapp.com',
    storageBucket: 'todocredit-8e731.firebasestorage.app',
    measurementId: 'G-GGVL7N3THS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQPxi_6gAveGJZwV_5hS3n2CBvtZ9yJ20',
    appId: '1:771248560614:android:df2435c77a8a96d7981e27',
    messagingSenderId: '771248560614',
    projectId: 'todocredit-8e731',
    storageBucket: 'todocredit-8e731.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj9ZcIsZksgNJiRfRnVYWxFgcr-7kvrOE',
    appId: '1:771248560614:ios:702bb7a4d082cd06981e27',
    messagingSenderId: '771248560614',
    projectId: 'todocredit-8e731',
    storageBucket: 'todocredit-8e731.firebasestorage.app',
    iosBundleId: 'com.example.creditapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCj9ZcIsZksgNJiRfRnVYWxFgcr-7kvrOE',
    appId: '1:771248560614:ios:702bb7a4d082cd06981e27',
    messagingSenderId: '771248560614',
    projectId: 'todocredit-8e731',
    storageBucket: 'todocredit-8e731.firebasestorage.app',
    iosBundleId: 'com.example.creditapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBYb45izHOd7bLeNjaLULLZKjBkwZZ6mFE',
    appId: '1:771248560614:web:d925bbf974797999981e27',
    messagingSenderId: '771248560614',
    projectId: 'todocredit-8e731',
    authDomain: 'todocredit-8e731.firebaseapp.com',
    storageBucket: 'todocredit-8e731.firebasestorage.app',
    measurementId: 'G-VWY0XDRW4N',
  );
}