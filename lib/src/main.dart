import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'user/login.dart'; //ReviewWrite

void main() async{
  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    // home:Swipe(),
    home: SignInDemo(),
  ));
}
