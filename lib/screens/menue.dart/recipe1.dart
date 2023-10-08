import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/model/model.dart';
import 'package:baisnab/screens/cartpage/addfvorite.dart';
import 'package:baisnab/screens/home_screen.dart';
import 'package:baisnab/screens/menue.dart/recipiedetails.dart';
import 'package:baisnab/screens/profile/profile_screen.dart';
import 'package:baisnab/screens/theme.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:ui_web';
import '../cartpage/cartpage.dart';

class HomePageeStatefulWidget extends StatefulWidget {
  final int selectedIndex;
  final List<Recipe> recipes;

  const HomePageeStatefulWidget({
    Key? key,
    required this.selectedIndex,
    required this.recipes,
  }) : super(key: key);

  @override
  _HomePageeState createState() => _HomePageeState();
}

class _HomePageeState extends State<HomePageeStatefulWidget> {
  final firestore = FirebaseFirestore.instance;

  final List<Recipe> favoriteRecipes = [];

  // Future<void> addRecipeToFavorites(Recipe recipe) async {
  //   try {
  //     final CollectionReference favoritesCollection =
  //         firestore.collection('fav');

  //     // Check if a recipe with the same recipeId already exists
  //     final QuerySnapshot existingRecipes = await favoritesCollection
  //         .where('recipeId', isEqualTo: recipe.recipeId)
  //         .get();

  //     if (existingRecipes.docs.isEmpty) {
  //       // Convert the recipe to a Map
  //       final Map<String, dynamic> recipeMap = {
  //         'recipeId': recipe.recipeId,
  //         'recipeTitle': recipe.recipeTitle,
  //         'recipename': recipe.recipename,
  //         'cookingTime': recipe.cookingTime,
  //         'image': recipe.image,
  //         'description': recipe.description,
  //       };

  //       await favoritesCollection.add(recipeMap);

  //       showCustomDialog('Recipe is added on Favorite Page ');
  //     } else {
  //       showCustomDialog('Recipe is already in Favorite Page');
  //     }
  //   } catch (e) {
  //     print(e.toString());

  //     showCustomDialog('Failed to add on the  Favorite Page ');
  //   }
  // }

  @override
 
  Future<void> showCustomDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recipe Added'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void>  addRecipeToFavorites(BuildContext context, Recipe recipe) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      if (user != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final CollectionReference favoritesCollection =
            firestore.collection('favs').doc(user.uid).collection('fav');

        // Check if a recipe with the same recipeId already exists
        final QuerySnapshot existingRecipes = await favoritesCollection
            .where('recipeId', isEqualTo: recipe.recipeId)
            .get();

        if (existingRecipes.docs.isEmpty) {
          final double recipename = recipe.recipename;

          final Map<String, dynamic> recipeMap = {
            'recipeId': recipe.recipeId,
            'recipeTitle': recipe.recipeTitle,
            'recipename': recipename,
            'cookingTime': recipe.cookingTime,
            'image': recipe.image,
            'description': recipe.description,
          };

          await favoritesCollection.add(recipeMap);

          showCustomDialog('Recipe is added on Favorite Page ');
        } else {
          showCustomDialog('Recipe is already in Favorite Page');
        }
      }
    } catch (e) {
      print(e.toString());

      showCustomDialog('Failed to add on the  Favorite Page ');
    }
  }

  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Consumer<ThemeNotifier>(builder: (context, themeProvider, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme(),
          // theme: ThemeData.light(), // Define your light theme here
          // darkTheme: ThemeData.dark(),
          //      home:

          //  theme:
          // Provider.of<ThemeNotifier>(context).getTheme();
          home: Scaffold(
            body: SafeArea(
              child: Container(
                height: 820,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
                          child: Text(
                            "Recipe List",
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = widget.recipes[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetPage(
                                    recipes: widget.recipes,
                                    recipe: recipe,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 480,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    shadowColor: Colors.tealAccent,
                                    color: const Color(0xFFF4F5FE),
                                    child: Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            recipe.image,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 80,
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            child: Column(
                                              children: [
                                                Text(
                                                  recipe.recipeTitle,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                Text(
                                                  'NRS ${recipe.recipename.toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 8.0),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 13),
                                                child: IconButton(
                                                  onPressed: () {
                                                    addRecipeToFavorites(
                                                        context,recipe);
                                                  },
                                                  icon: const Icon(
                                                    Icons.favorite,
                                                    size: 14.0,
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 13),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: Colors.black,
                                                size: 14.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                            recipes: widget.recipes,
                            recipeId: '',
                          ),
                        ),
                      );
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
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  IconButton(
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
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 26,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                             
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
          ));
    });
  }
}
