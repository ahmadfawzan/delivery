// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBhaEW1_LKo0em8gqFLbMXUDGIQwlmXXV0',
    appId: '1:646529970400:web:2b9d160bfa1186a1e16085',
    messagingSenderId: '646529970400',
    projectId: 'delivery-31bd4',
    authDomain: 'delivery-31bd4.firebaseapp.com',
    storageBucket: 'delivery-31bd4.appspot.com',
    measurementId: 'G-6C5ERL7C5M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8-pffiFYEvS8CrSIN9LAENus1MgcDtso',
    appId: '1:646529970400:android:d1c66c5a73180286e16085',
    messagingSenderId: '646529970400',
    projectId: 'delivery-31bd4',
    storageBucket: 'delivery-31bd4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCx_zLAebb3tIq-GdB-age-sJaa1sB6Aa4',
    appId: '1:646529970400:ios:4067d07b2d78f86ee16085',
    messagingSenderId: '646529970400',
    projectId: 'delivery-31bd4',
    storageBucket: 'delivery-31bd4.appspot.com',
    iosBundleId: 'com.example.delivery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCx_zLAebb3tIq-GdB-age-sJaa1sB6Aa4',
    appId: '1:646529970400:ios:4067d07b2d78f86ee16085',
    messagingSenderId: '646529970400',
    projectId: 'delivery-31bd4',
    storageBucket: 'delivery-31bd4.appspot.com',
    iosBundleId: 'com.example.delivery',
  );
}
