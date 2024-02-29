import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/model/model.dart';
import 'package:baisnab/users/screens/cartpage/addfvorite.dart';
import 'package:baisnab/users/screens/home_screen.dart';
import 'package:baisnab/users/screens/menue.dart/recipiedetails.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:baisnab/users/theme.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:ui_web';
import '../../profile/profile_screen.dart';
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

  Future<void> addRecipeToFavorites(BuildContext context, Recipe recipe) async {
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
          final double? recipename = recipe.recipename;

          final Map<String, dynamic> recipeMap = {
            'recipeId': recipe.recipeId,
            'recipeTitle': recipe.recipeTitle,
            'recipename': recipename,
            'cookingTime': recipe.cookingTime,
            'image': recipe.image,
            'index':recipe.index,
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
    // final recipeProvider = Provider.of<RecipeProvider>(context);
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Consumer<ThemeNotifier>(builder: (context, themeProvider, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme(),
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

                        return FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('cart')
                              .where('recipeTitle',
                                  isEqualTo: widget.recipes[index].recipeTitle)
                               .where('index', isEqualTo: recipe.index)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return LinearProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Text('Data not found');
                            }

                            final recipeItem = snapshot.data!.docs[0].data();
                            if (recipeItem is Map<String, dynamic>) {
                              final recipeId = recipeItem['recipeId'];
                              final recipeTitle = recipeItem['recipeTitle'];
                              final recipename = recipeItem['recipename'];
                               final index = recipeItem['index'];
                              // Handle the case where recipename is null or not present
                              final double? recipenameAsDouble =
                                  recipename != null
                                      ? (recipename as num).toDouble()
                                      : null;

                              final cookingTime = recipeItem['cookingTime'];
                              final image = recipeItem['image'];

                              final ratingValue = recipeItem['rating'];

                             
                              final double? rating = ratingValue != null
                                  ? (ratingValue as num).toDouble()
                                  : null;

                              final quantityValue = recipeItem['quantity'];

                              final int? quantity = quantityValue != null
                                  ? (quantityValue as num).toInt()
                                  : null;

                              final description = recipeItem['description'];

                              final recipe = Recipe(
                                recipeId: recipeId,
                                recipeTitle: recipeTitle,
                                recipename: recipenameAsDouble,
                                cookingTime: cookingTime,
                                image: image,
                                index:index,
                                rating: 4,
                                quantity: 1,
                                description: description,
                              );
                            

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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        shadowColor: Colors.tealAccent,
                                        color: const Color(0xFFF4F5FE),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          buildRecipeImage(recipe),  
                                              // Image.asset(
                                              //   recipe.image,
                                              //   fit: BoxFit.cover,
                                              //   width: 70,
                                              //   height: 80,
                                              // ),
                                              const SizedBox(height: 10),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                  vertical: 15,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      recipe.recipeTitle,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    Text(
                                                      'NRS ${recipe.recipename?.toStringAsFixed(2) ?? "0.00"}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    Row(
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 13,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        addRecipeToFavorites(
                                                            context, recipe);
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 0,
                                                  vertical: 13,
                                                ),
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
                            } else {
                              // Handle the case when recipeItem is null
                              print('Error: recipeItem is null');
                              return Container(); // Return an empty container or a placeholder widget
                            }
                          },
                        );
                      },
                    ))
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
                      Icons.home,
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
                          builder: (context) => UserProfileScreen(),
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
          ));
    });
  }
}
Widget buildRecipeImage(Recipe recipe) {
  if (recipe.image != null && recipe.image.startsWith('https://')) {
    // Image is a network image
    return Image.network(
      recipe.image,
      fit: BoxFit.cover,
      width: 70,
      height: 80,
    );
  } else if (recipe.image != null && recipe.image.startsWith('assets/')) {
    // Image is from assets
    return Image.asset(
      recipe.image,
      fit: BoxFit.cover,
      width: 70,
      height: 80,
    );
  } else {
   
    return Image.asset(
      recipe.image, // Replace with your default image path
      fit: BoxFit.cover,
      width: 70,
      height: 80,
    );
  }
}

Future<String?> fetchImageFromFirestore(String recipeTitle) async {
  try {
    DocumentSnapshot recipeSnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(recipeTitle)
        .get();

    if (recipeSnapshot.exists) {
      // Assuming the image URL is stored in the 'image' field
      return recipeSnapshot['image'] ?? '';
    } else {
      print('Recipe not found in Firestore');
      return null;
    }
  } catch (e) {
    print('Error fetching image from Firestore: $e');
    return null;
  }
}





