import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/googlemap/googlemap.dart';
import 'package:baisnab/model/model.dart';
import 'package:baisnab/screens/cartpage/cartpage.dart';
import 'package:baisnab/screens/home_screen.dart';
import 'package:baisnab/screens/menue.dart/recipiedetails.dart';
import 'package:baisnab/screens/profile/profile_screen.dart';
import 'package:baisnab/screens/theme.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  final List<Recipe> recipes;
  final String recipeId;

  FavoritePage({required this.recipes, required this.recipeId});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isDark = false;
  double rating = 0.0; // Default value

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _deleteItem(BuildContext context, String recipeId) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference cartCollection =
          firestore.collection('favs').doc(user.uid).collection('fav');

      try {
        await cartCollection.doc(recipeId).delete();
        setState(() {});
      } catch (e) {
        print('Error deleting recipe: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);

    return Consumer<ThemeNotifier>(builder: (context, themeProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProvider.getTheme(),
        home: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: 620,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        child: Row(
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
                            SizedBox(width: 40),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              child: Text(
                                "Favorite items",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, authSnapshot) {
                          if (authSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (authSnapshot.hasError) {
                            return Text(
                                'Authentication Error: ${authSnapshot.error}');
                          }

                          final user = FirebaseAuth.instance.currentUser;

                          if (user == null) {
                            return Center(
                              child: Text(
                                  'You need to log in to view your favorite.'),
                            );
                          }

                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('favs')
                                .doc(user.uid)
                                .collection('fav')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child:
                                      Text('Your favorite recipe is empty.'),
                                );
                              }

                              List<Recipe> recipes =
                                  snapshot.data!.docs.map((doc) {
                                final rating =
                                    (doc.data() as Map<String, dynamic>?)?[
                                        'rating'];

                                final parsedRating =
                                    (rating ?? 0.0) as double;

                                final quantity =
                                    (doc.data() as Map<String, dynamic>?)?[
                                        'quantity'];
                                final price =
                                    (doc.data() as Map<String, dynamic>?)?[
                                        'price'];

                                return Recipe(
                                  recipeTitle: doc['recipeTitle'],
                                  cookingTime: doc['cookingTime'],
                                  description: doc['description'],
                                  image: doc['image'],
                                  rating: parsedRating,
                                  recipeId: doc.id,
                                  quantity: 1,
                                  recipename: doc['recipename'],
                                );
                              }).toList();

                              return ListView.builder(
                                itemCount: recipes.length,
                                itemBuilder: (context, index) {
                                  final recipe = recipes[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetPage(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    recipe.image,
                                                    fit: BoxFit.cover,
                                                    width: 85,
                                                    height: 85,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 15),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          recipe.recipeTitle,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        const SizedBox(height: 8.0),
                                                        Text(
                                                          'NRS ${recipe.recipename.toStringAsFixed(2)}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                                horizontal: 30,
                                                                vertical: 13),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            _deleteItem(
                                                                context,
                                                                recipe.recipeId);
                                                          },
                                                        ),
                                                      )
                                                    ],
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
                              );
                            },
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
                        ),
                      );
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
                            recipes: [],
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
          ),
        ),
      );
    });
  }
}
