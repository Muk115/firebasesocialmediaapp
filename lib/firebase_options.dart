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
    apiKey: 'AIzaSyDSB8FXdTy6wk4yR2Sq72i8G7YUfLWcQqM',
    appId: '1:1098185772264:web:bd87b7c618ef4c1e330d5d',
    messagingSenderId: '1098185772264',
    projectId: 'social-media-e3490',
    authDomain: 'social-media-e3490.firebaseapp.com',
    storageBucket: 'social-media-e3490.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS2oIFuYcdFIAf0TCkgEkJW95PmXToMDg',
    appId: '1:1098185772264:android:aa7d69e5ec60c284330d5d',
    messagingSenderId: '1098185772264',
    projectId: 'social-media-e3490',
    storageBucket: 'social-media-e3490.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJOWfc1hn5JMKC3YqEF7n3jQ8KNNMF3-w',
    appId: '1:1098185772264:ios:51be5a1089b43208330d5d',
    messagingSenderId: '1098185772264',
    projectId: 'social-media-e3490',
    storageBucket: 'social-media-e3490.appspot.com',
    iosClientId: '1098185772264-1q0lhd19garctdv4tdbuag1728jsjq6k.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasesocialmediaapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJOWfc1hn5JMKC3YqEF7n3jQ8KNNMF3-w',
    appId: '1:1098185772264:ios:8914f2087c8cb1ac330d5d',
    messagingSenderId: '1098185772264',
    projectId: 'social-media-e3490',
    storageBucket: 'social-media-e3490.appspot.com',
    iosClientId: '1098185772264-qr7apjqhhveq3ov6sphn5272ct2bc5am.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasesocialmediaapp.RunnerTests',
  );
}
