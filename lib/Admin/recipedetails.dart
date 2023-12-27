import 'package:baisnab/Admin/edit.dart';
import 'package:baisnab/Admin/inner_screens/edit_prod.dart';
import 'package:baisnab/users/theme.dart/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/model.dart';

class RecipeDetailsPage extends StatefulWidget {
  final String recipeTitle;

  RecipeDetailsPage({
    Key? key,
    required this.recipeTitle,
  }) : super(key: key);

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late Recipe _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = Recipe(
      recipeId: '',
      recipeTitle: '',
      cookingTime: '',
      recipename: 0,
      rating: 0,
      description: '',
      image: '',
    );
    fetchData();
  }

fetchData() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('recipeTitle', isEqualTo: widget.recipeTitle)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot recipeSnapshot = querySnapshot.docs.first;
      Map<String, dynamic>? recipeData = recipeSnapshot.data() as Map<String, dynamic>?;

      if (recipeData != null) {
        double recipename = (recipeData['recipename'] ?? 0).toDouble();

        setState(() {
          _recipe = Recipe.fromMap(recipeData);
          _recipe.recipename = recipename;
        });
      } else {
        print('Recipe data is null for title: ${widget.recipeTitle}');
      }
    } else {
      print('Recipe not found for title: ${widget.recipeTitle}');
    }
  } catch (e, stackTrace) {
    print('Error fetching recipe: $e');
    print('StackTrace: $stackTrace');
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
              padding: const EdgeInsets.all(16),
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
                          width: 40,
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
                            horizontal: 20, vertical: 20),
                        child: Text(
                          "Details of ${widget.recipeTitle ?? 'Unknown'}",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        _recipe.image.isNotEmpty
                            ? 'assets/${_recipe.image}'
                            : 'assets/',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Recipe title: ${_recipe.recipeTitle}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cooking Time: ${_recipe.cookingTime}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Descriptions: \n ${_recipe.description}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(206, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Color.fromARGB(255, 248, 158, 67),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>AdminEditCartPage(
                                 
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 0, 7, 15),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Edit Recipe',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
