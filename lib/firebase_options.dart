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
    apiKey: 'AIzaSyD0oefsRCB8pg1oVeWZznW0M7mLxqboILk',
    appId: '1:257578190315:web:2d8c21847761d2065405ae',
    messagingSenderId: '257578190315',
    projectId: 'messaging-app-d2baa',
    authDomain: 'messaging-app-d2baa.firebaseapp.com',
    storageBucket: 'messaging-app-d2baa.appspot.com',
    measurementId: 'G-W5WK1QZ91G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9WCGecQujiBCARlRsZYGsqrziGXAWYtU',
    appId: '1:257578190315:android:8bd628b226ed39035405ae',
    messagingSenderId: '257578190315',
    projectId: 'messaging-app-d2baa',
    storageBucket: 'messaging-app-d2baa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrztQLidEn8hBsKQh6rvDMNmugAT3TpRU',
    appId: '1:257578190315:ios:33f22b2ff8b42dc65405ae',
    messagingSenderId: '257578190315',
    projectId: 'messaging-app-d2baa',
    storageBucket: 'messaging-app-d2baa.appspot.com',
    iosClientId: '257578190315-78mata10lgud2m0jamddkseinjjuph5a.apps.googleusercontent.com',
    iosBundleId: 'com.example.messagingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrztQLidEn8hBsKQh6rvDMNmugAT3TpRU',
    appId: '1:257578190315:ios:33f22b2ff8b42dc65405ae',
    messagingSenderId: '257578190315',
    projectId: 'messaging-app-d2baa',
    storageBucket: 'messaging-app-d2baa.appspot.com',
    iosClientId: '257578190315-78mata10lgud2m0jamddkseinjjuph5a.apps.googleusercontent.com',
    iosBundleId: 'com.example.messagingApp',
  );
}
