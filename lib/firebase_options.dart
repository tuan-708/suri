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
    apiKey: 'AIzaSyACnp5SGXqnLEp4sltwIEt33f99_ZaDdaw',
    appId: '1:395483272163:web:802fa761d7a9e6b537c6d6',
    messagingSenderId: '395483272163',
    projectId: 'suri-b05d4',
    authDomain: 'suri-b05d4.firebaseapp.com',
    storageBucket: 'suri-b05d4.firebasestorage.app',
    measurementId: 'G-F9J5CKVRWS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGd4Gu1BRyDz5_rkqMxWGRz1PFN9a0KWk',
    appId: '1:395483272163:android:c6a95dd08d6828b137c6d6',
    messagingSenderId: '395483272163',
    projectId: 'suri-b05d4',
    storageBucket: 'suri-b05d4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDD_Mns-vyYQGGSyBQMuq0HQh_q5q7eeGU',
    appId: '1:395483272163:ios:41bfddf85ca9277d37c6d6',
    messagingSenderId: '395483272163',
    projectId: 'suri-b05d4',
    storageBucket: 'suri-b05d4.firebasestorage.app',
    iosBundleId: 'com.dion.suristore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDD_Mns-vyYQGGSyBQMuq0HQh_q5q7eeGU',
    appId: '1:395483272163:ios:41bfddf85ca9277d37c6d6',
    messagingSenderId: '395483272163',
    projectId: 'suri-b05d4',
    storageBucket: 'suri-b05d4.firebasestorage.app',
    iosBundleId: 'com.dion.suristore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyACnp5SGXqnLEp4sltwIEt33f99_ZaDdaw',
    appId: '1:395483272163:web:46a69005e51b926537c6d6',
    messagingSenderId: '395483272163',
    projectId: 'suri-b05d4',
    authDomain: 'suri-b05d4.firebaseapp.com',
    storageBucket: 'suri-b05d4.firebasestorage.app',
    measurementId: 'G-3BQ907KSBC',
  );

}