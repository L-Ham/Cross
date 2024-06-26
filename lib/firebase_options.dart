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
    apiKey: 'AIzaSyDIocLGU7ZWBUZ8cagNNSLS2FSjiNcKy4I',
    appId: '1:622354436571:web:a8c9c23c9bc41a61cc17fe',
    messagingSenderId: '622354436571',
    projectId: 'reddit-bylham',
    authDomain: 'reddit-bylham.firebaseapp.com',
    storageBucket: 'reddit-bylham.appspot.com',
    measurementId: 'G-MP5DG2YEVF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVAMHZLmNU6gh6bXieoroLNq6B-H4MOY8',
    appId: '1:622354436571:android:8693a3637362d01ecc17fe',
    messagingSenderId: '622354436571',
    projectId: 'reddit-bylham',
    storageBucket: 'reddit-bylham.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIgdk9qyzqoJ2VW3wi0xeP7L4nbnwcw_8',
    appId: '1:622354436571:ios:8c4941ac058d3663cc17fe',
    messagingSenderId: '622354436571',
    projectId: 'reddit-bylham',
    storageBucket: 'reddit-bylham.appspot.com',
    androidClientId: '622354436571-0csk237en702ap7l52lrn8qdv9cnm9k8.apps.googleusercontent.com',
    iosClientId: '622354436571-nnb93c2bhde2spsje5k7kitgmvdb6s6i.apps.googleusercontent.com',
    iosBundleId: 'com.example.redditBelHam',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIgdk9qyzqoJ2VW3wi0xeP7L4nbnwcw_8',
    appId: '1:622354436571:ios:4fcb81b05712e949cc17fe',
    messagingSenderId: '622354436571',
    projectId: 'reddit-bylham',
    storageBucket: 'reddit-bylham.appspot.com',
    androidClientId: '622354436571-0csk237en702ap7l52lrn8qdv9cnm9k8.apps.googleusercontent.com',
    iosClientId: '622354436571-hh0k0s4n24usurbqm346m7ea2a5p2905.apps.googleusercontent.com',
    iosBundleId: 'com.example.redditBelHam.RunnerTests',
  );
}