import 'package:baisnab/screens/home_screen.dart';
import 'package:baisnab/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class FirestoreService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('cart');

  Future<List<DocumentSnapshot>> getDocuments() async {
    QuerySnapshot querySnapshot = await _collection.get();
    return querySnapshot.docs;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        home: AnimatedSplashScreen(
          splash: 'assets/images/baisnab.jpg',
          splashIconSize:
              200, // use any widget WelcomeScreen()   
          nextScreen:HomeScreen(title: '', recipeMenu: [],),
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: const Color.fromARGB(255, 240, 249, 245),
          duration: 4000,
        )
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return const HomeScreen();
        //     } else {
        //       return Splash2();
        //     }
        //   },
        // ),
        );
  }
}
