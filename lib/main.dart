import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/model/model.dart';
import 'package:baisnab/screens/home_screen.dart';
import 'package:baisnab/screens/theme.dart/theme.dart';
import 'package:baisnab/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:ui_web';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:khalti_flutter/khalti_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlutterEmailSender();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider(Recipe)),
     ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
     
     
    ),],
   child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_ce2f2ab40248417dbe23b8f447466984',
        enabledDebugging: true,
        builder: (context, navKey) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        home: AnimatedSplashScreen(
          splash: 'assets/images/baisnab.jpg',
          splashIconSize:
              200, // use any widget  HomeScreen(title: '', recipeMenu: [],) , 
          nextScreen:  WelcomeScreen(),
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: const Color.fromARGB(255, 240, 249, 245),
          duration: 4000,
        ),
         navigatorKey: navKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
        );}
        );
  }

}
