// // File generated by FlutterFire CLI.
// // ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;

// /// Default [FirebaseOptions] for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       return web;
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         return macos;
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions web = FirebaseOptions(
//     apiKey: 'AIzaSyDga6vNlXUyJb_CVMqKXSoWNtkidhddl9M',
//     appId: '1:163841058419:web:05b61592cad8668c206c06',
//     messagingSenderId: '163841058419',
//     projectId: 'tinji-62063',
//     authDomain: 'tinji-62063.firebaseapp.com',
//     storageBucket: 'tinji-62063.appspot.com',
//     measurementId: 'G-P6WK61PQVD',
//   );

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyDpw6XDJ6ozBO3C6cLJ4XXQmGPNkAQMPic',
//     appId: '1:163841058419:android:943433eb17a0958b206c06',
//     messagingSenderId: '163841058419',
//     projectId: 'tinji-62063',
//     storageBucket: 'tinji-62063.appspot.com',
//   );

//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyD8WB3AA2hOi4AakW2oUdIiykMNSwK-KEI',
//     appId: '1:163841058419:ios:eba2c643c419075e206c06',
//     messagingSenderId: '163841058419',
//     projectId: 'tinji-62063',
//     storageBucket: 'tinji-62063.appspot.com',
//     androidClientId: '163841058419-t5m49a7eineu8u8bu8ct5sv2hus3uce5.apps.googleusercontent.com',
//     iosClientId: '163841058419-7k5gust1hrge8hdn9i44hcelm0bf3iog.apps.googleusercontent.com',
//     iosBundleId: 'com.example.tinji',
//   );

//   static const FirebaseOptions macos = FirebaseOptions(
//     apiKey: 'AIzaSyD8WB3AA2hOi4AakW2oUdIiykMNSwK-KEI',
//     appId: '1:163841058419:ios:eba2c643c419075e206c06',
//     messagingSenderId: '163841058419',
//     projectId: 'tinji-62063',
//     storageBucket: 'tinji-62063.appspot.com',
//     androidClientId: '163841058419-t5m49a7eineu8u8bu8ct5sv2hus3uce5.apps.googleusercontent.com',
//     iosClientId: '163841058419-7k5gust1hrge8hdn9i44hcelm0bf3iog.apps.googleusercontent.com',
//     iosBundleId: 'com.example.tinji',
//   );
// }
