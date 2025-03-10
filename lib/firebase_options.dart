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
    apiKey: 'AIzaSyBInalNcBNGJizDkrpmw_eiSRZ_ss4TWHo',
    appId: '1:560748412232:web:cf2d952969fd1a1ca8477d',
    messagingSenderId: '560748412232',
    projectId: 'monitoringfisikapp',
    authDomain: 'monitoringfisikapp.firebaseapp.com',
    storageBucket: 'monitoringfisikapp.appspot.com',
    measurementId: 'G-NVX1Q8JBD9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVSycQEE4zPGX0vCgwo_3X8JBJxlE1G8Y',
    appId: '1:560748412232:android:825607df78659b61a8477d',
    messagingSenderId: '560748412232',
    projectId: 'monitoringfisikapp',
    storageBucket: 'monitoringfisikapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEnpZLDXYmEMUCw3_OrrxWZpH0rcE65Vw',
    appId: '1:560748412232:ios:6b34a5f978a42cd2a8477d',
    messagingSenderId: '560748412232',
    projectId: 'monitoringfisikapp',
    storageBucket: 'monitoringfisikapp.appspot.com',
    iosBundleId: 'com.example.flutterProjekApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEnpZLDXYmEMUCw3_OrrxWZpH0rcE65Vw',
    appId: '1:560748412232:ios:c7a7b75e0b4675cda8477d',
    messagingSenderId: '560748412232',
    projectId: 'monitoringfisikapp',
    storageBucket: 'monitoringfisikapp.appspot.com',
    iosBundleId: 'com.example.flutterProjekApp.RunnerTests',
  );
}
