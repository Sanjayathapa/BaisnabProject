import 'package:baisnab/Admin/providers/dark_theme_provider.dart';
import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/model/model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:baisnab/users/screens/notificatiom/notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:baisnab/users/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'users/theme.dart/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//   RecipeProvider recipeProvider = RecipeProvider(Recipe(recipeId: '', recipeTitle: '', recipename: 0, cookingTime: '', rating: 4, description: '', image: '', isOutOfStock: false , index: 0,ingredients: []));
// await RecipeProvider(Recipe).addRecipesToFirestore();
  FlutterEmailSender();
  // await Firebase.initializeApp();
  //  List<Recipe> recipes = await fetchRecipesFromFirestore();
  //    print(recipes);
  //  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  //Remove this method to stop OneSignal Debugging 
OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

OneSignal.initialize("66087130-0c75-4c54-8daa-afbde9dff111");

OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   NotificationService().initNotification();
  
  tz.initializeTimeZones();
   runApp(
     MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_) => IconNotifier()),
        ChangeNotifierProvider(create: (_) => RecipeProvider(Recipe)),  
     ChangeNotifierProvider( create: (_) => ThemeNotifier(), ),
     ChangeNotifierProvider(create: (_) => MessageCountProvider()),   
     ChangeNotifierProvider(create: (_) => LoadingProvider()),  
   
      
    ],
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
              200, // use any widgetHomee()AdminRecipeList()  HomeScreen(title: '', recipeMenu: [],)LoginPage() , 
          nextScreen: WelcomeScreen( ) ,
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

