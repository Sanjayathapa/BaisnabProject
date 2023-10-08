import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/screens/profile/profile_screen.dart';
import 'package:baisnab/screens/theme.dart/theme.dart';
import 'package:baisnab/searchwidget/searchbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../short/short.dart';
// import 'dart:ui_web';
import '../short/shorthomescreen.dart';
import 'package:flutter/material.dart';
import '../data/recipelist.dart';
import '../slider/CarouselSlider.dart';
// import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';
import 'cartpage/addfvorite.dart';
import 'cartpage/cartpage.dart';
import 'menue.dart/recipe1.dart';
import 'menue.dart/recipiedetails.dart';
import 'moreitems.dart';

class HomeScreen extends StatefulWidget {
  final List recipeMenu;
  final String title;

  const HomeScreen({Key? key, required this.title, required this.recipeMenu})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  bool isDark = false;
   @override
  void initState() {
    super.initState();
    // Listen for authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        // If the user is authenticated, fetch and set the user's theme
        _fetchAndSetUserTheme(user.uid);
      }
    });
  }

  Future<void> _fetchAndSetUserTheme(String userId) async {
    try {
      final userThemeSnapshot = await FirebaseFirestore.instance
          .collection('usertheme')
          .doc(userId)
          .get();

      if (userThemeSnapshot.exists) {
        final isDark = userThemeSnapshot['isDarkMode'] ?? false;
        final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
        themeNotifier.setTheme(isDark ? ThemeData.dark() : ThemeData.light());
      }
    } catch (e) {
      print('Error fetching user theme: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeNotifier>(context).getTheme(),
          
          home: SafeArea(
            child: Scaffold(
              // backgroundColor: const Color(0xFFF9FEF4),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      width: 500, // Specify the desired width

                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Container(
                                          child: IconButton(
                                        icon: Icon(
                                          themeProvider.isDarkMode
                                              ? Icons.brightness_2_outlined
                                              : Icons.wb_sunny_outlined,
                                        ),
                                        onPressed: () {
                                          themeProvider.toggleTheme();
                                           final user = FirebaseAuth.instance.currentUser;
                                      if (user != null) {
                                        _storeUserThemePreference(user.uid, themeProvider.isDarkMode);
                                      }
                                        },
                                      )),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                        icon: const Icon(
                                          Icons.logout,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                              ]),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(children: [
                              ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [Colors.red, Colors.blue],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text("Welcome to our Baisnab sweets",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            height: 200,
                            child: CarouselSliderWidget(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 120,
                            width: 410,
                            child: SearchScreen(),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Our foods and sweets product',
                                    style: TextStyle(
                                      // color: Colors.black,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    //  GoogleFonts.lato
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => moreitems(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'More Items >>>',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Delicious Dishes',
                            // GoogleFonts.lato
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                             child: Consumer<RecipeProvider>(
                                  builder: (context, recipeProvider, child){
                                     return Container( 
                            child: Row(
                              children: [
                                mypro(context, 0, 'Dosa', recipeProvider.recipes),
                                mypro(context, 4, 'Nan,Roti,Kulcha ', recipeProvider.recipes),
                              ],
                             ));
                              }
                              )),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Consumer<RecipeProvider>(
                                  builder: (context, recipeProvider, child){
                               return Container( 
                                child:Row(
                                  children: [
                                    mypro(context, 2, 'Thali Set',
                                        recipeProvider.recipes),
                                    mypro(context, 3, 'Biryani,Rice,pulav',
                                       recipeProvider.recipes),
                                  ],
                                ));
                              }
                              )),
                          const SizedBox(height: 20),
                          Text(
                            'Sweet Items',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 23,
                              // GoogleFonts.lato
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                             child: Consumer<RecipeProvider>(
                                  builder: (context, recipeProvider, child){ 
                                    return Container( 
                            child: Row(
                              children: [
                                mypro(context, 5, 'Laduu', recipeProvider.recipes),
                                mypro(context, 9, 'Rasburry ', recipeProvider.recipes),
                              ],
                            ));
                              }
                              )),
                        ],
                      ),
                    ),
                  )),

              bottomNavigationBar: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAF5E1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                recipeMenu: [],
                                title: '',
                              ),
                            ));
                      },
                      icon: const Icon(
                        Icons.home_outlined,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritePage(
                                recipes: [], recipeId: '',
                                // recipe:recipe,
                              ),
                            ));
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                context: context,
                                recipeTitle: '',
                              ),
                            ));
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  UserProfileScreen(
                             
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }  
  Future<void> _storeUserThemePreference(String userId, bool isDarkMode) async {
    try {
      await FirebaseFirestore.instance
          .collection('usertheme')
          .doc(userId)
          .set({'isDarkMode': isDarkMode});
    } catch (e) {
      print('Error setting user theme: $e');
    }
  }
}


