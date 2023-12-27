import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/users/theme.dart/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile/profile_screen.dart';
import '../short/shorthomescreen.dart';
import 'cartpage/addfvorite.dart';
import 'cartpage/cartpage.dart';
import 'home_screen.dart';
import 'menue.dart/addtocartpage.dart';
import 'menue.dart/recipe1.dart';

class moreitems extends StatefulWidget {
  const moreitems({super.key});

  @override
  State<moreitems> createState() => _moreitemsState();
}

class _moreitemsState extends State<moreitems> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: false);
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeNotifier>(context).getTheme(),
          // theme: ThemeData.light(), // Define your light theme here
          // darkTheme: ThemeData.dark(),
          home: SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Burger,Sandwich And Bread',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          //  GoogleFonts.lato
                        ),
                        Consumer<RecipeProvider>(
                            builder: (context, recipeProvider, child) {
                          return Container(
                            child: Row(
                              children: [
                                mypros(context, 6, 'Burger,Sandwich,Bread',
                                    recipeProvider.recipes),
                              ],
                            ),
                          );
                        })
                      ]),
                ),
                const SizedBox(height: 20),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Pasta ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    //  GoogleFonts.lato
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<RecipeProvider>(
                          builder: (context, recipeProvider, child) {
                        return Container(
                            child: Row(
                          children: [
                            mypros(context, 7, 'Pasta', recipeProvider.recipes),
                          ],
                        ));
                      })),
                ]),
                const SizedBox(height: 20),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Hot and Cold Bevarage  ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    //  GoogleFonts.lato
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<RecipeProvider>(
                          builder: (context, recipeProvider, child) {
                        return Container(
                            child: Row(
                          children: [
                            mypros(context, 10, 'Tea and Coffee',
                                recipeProvider.recipes),
                          ],
                        ));
                      })),
                ]),
                const SizedBox(height: 20),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Salad And Raita ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    //  GoogleFonts.lato
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<RecipeProvider>(
                          builder: (context, recipeProvider, child) {
                        return Container(
                            child: Row(
                          children: [
                            mypros(context, 8, 'salad and raita',
                                recipeProvider.recipes)
                          ],
                        ));
                      })),
                ]),
              ],
            )),
            bottomNavigationBar: Container(
              height: 45,
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
                      Icons.home,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      var recipe;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritePage(
                              recipes: [], recipeId: '',
                              //  recipe: recipe,
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
                      Icons.person,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          )));
    });
  }
}
