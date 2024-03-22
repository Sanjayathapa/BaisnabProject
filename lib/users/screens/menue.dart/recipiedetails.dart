// import 'package:baisnab/data/recipelist.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'dart:js';
// import '../../../model/model.dart';
// import '../../theme.dart/theme.dart';
// import 'addtocartpage.dart';

// class RecipeDetPage extends StatefulWidget {
//   final Recipe recipe;

//   RecipeDetPage({
//     Key? key,
//     required this.recipe,
//     required List<Recipe> recipes,
//   }) : super(key: key);

//   @override
//   _RecipeDetPageState createState() => _RecipeDetPageState();
// }

// class _RecipeDetPageState extends State<RecipeDetPage> {
//   bool isDark = false;
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     final themeProvider = Provider.of<ThemeNotifier>(context);
//     return Consumer<ThemeNotifier>(builder: (context, themeProvider, child) {
//       return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: themeProvider.getTheme(),
//           // theme: ThemeData.light(), // Define your light theme here
//           // darkTheme: ThemeData.dark(),
//           home: SafeArea(
//               child: Scaffold(
//             body: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: 50,
//                         width: 40,
//                         child: IconButton(
//                           icon: const Icon(Icons.arrow_back_ios_sharp),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5, vertical: 20),
// // GoogleFonts.lato
//                       child: Text(
//                         " Details of ${widget.recipe.recipeTitle}",
//                         style: TextStyle(
//                           // color: Colors.black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     buildRecipeImge(widget.recipe),
//                     // Image.asset(
//                     //   widget.recipe.image,
//                     //   width: double.infinity,
//                     //   height: 200,
//                     //   fit: BoxFit.cover,
//                     // ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Recipe title: ${widget.recipe.recipeTitle}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Cooking Time: ${widget.recipe.cookingTime}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
                  
//                     const SizedBox(height: 16),
//                     Text(
//                       'Descriptions: \n ${widget.recipe.description}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     Center(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(209, 60),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                           backgroundColor:
//                               Color.fromARGB(255, 248, 158, 67), // Set the background color
//                           foregroundColor: Colors.white,
//                         ),
//                         onPressed: () {
                         
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => AddToCartPage(recipe: widget.recipe,
                                        
//                                       )));
//                         },
//                         // GoogleFonts.lato
//                         child: Row(
//                           children: [
//                             const Icon(Icons.shopping_cart,
//                                color: Color.fromARGB(255, 0, 7, 15)),
//                                SizedBox(width: 10,),
//                             Text(
//                               'Make Sure to\nAdd in Cartpage',
//                               style: TextStyle(
//                                 // color: Colors.black,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ]),
//             ),
//           )));
//     });
//   }
// }
// Widget buildRecipeImge(Recipe recipe) {
//   if (recipe.image != null && recipe.image.startsWith('https://')) {
//     // Image is a network image
//     return Image.network(
//       recipe.image,
//       fit: BoxFit.cover,
//       width:double.infinity,
//       height: 200,
//     );
//   } else if (recipe.image != null && recipe.image.startsWith('assets/')) {
//     // Image is from assets
//     return Image.asset(
//       recipe.image,
//       fit: BoxFit.cover,
//       width: double.infinity,
//       height: 200,
//     );
//   } else {
   
//     return Image.asset(
//       recipe.image, // Replace with your default image path
//       fit: BoxFit.cover,
//       width: 200,
//       height: 160,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:baisnab/data/recipelist.dart';
import 'package:provider/provider.dart';
import '../../../model/model.dart';
import '../../theme.dart/theme.dart';
import 'addtocartpage.dart';

class RecipeDetPage extends StatefulWidget {
  final Recipe recipe;
  final List<List<Recipe>> recipes;

  RecipeDetPage({
    Key? key,
    required this.recipe,
    required this.recipes,
  }) : super(key: key);

  @override
  _RecipeDetPageState createState() => _RecipeDetPageState();
}

class _RecipeDetPageState extends State<RecipeDetPage> {
  bool isDark = false;

  // Function to handle recipe selection
  void handleRecipeSelection(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetPage(
          recipe: recipe,
          recipes: widget.recipes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Consumer<ThemeNotifier>(
      builder: (context, themeProvider, child) {
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
                              horizontal: 5, vertical: 20),
                          child: Text(
                            " Details of ${widget.recipe.recipeTitle}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                     Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRecipeImge(widget.recipe),
                    const SizedBox(height: 16),
                    Text(
                      'Recipe title: ${widget.recipe.recipeTitle}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Cooking Time: ${widget.recipe.cookingTime}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Descriptions: \n ${widget.recipe.description}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),]),
                    const SizedBox(height: 22),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(209, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor:
                              Color.fromARGB(255, 248, 158, 67),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddToCartPage(
                                recipe: widget.recipe,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_cart,
                                color: Color.fromARGB(255, 0, 7, 15)),
                            SizedBox(width: 10),
                            Text(
                              'Make Sure to\nAdd in Cartpage',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                      
                   Text(
                      'Suggestions:',
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.recipes.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: List.generate(
                              widget.recipes[index].length,
                              (i) {
                                final recipe = widget.recipes[index][i];
                                return GestureDetector(
                                  onTap: () {
                                    handleRecipeSelection(recipe);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                       child: 
                                        // buildImge(widget.recipe),
                                     Image.asset(
                                        recipe.image,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// Widget buildImge(Recipe recipe) {
//   if (recipe.image != null && recipe.image.startsWith('https://')) {
//     return Image.network(
//       recipe.image,
//       fit: BoxFit.cover,
//       width: 100,
//     height: 100,
//     );
//   } else if (recipe.image != null && recipe.image.startsWith('assets/')) {
//     return Image.asset(
//       recipe.image,
//       fit: BoxFit.cover,
//        width: 100,
//     height: 100,
//     );
//    } }
  //  else {
  //   return Image.asset(
  //     'assets/default_image.jpg',
  //     fit: BoxFit.cover,
  //       width: 100,
  //   height: 100,
  //   );
  // }
// }
Widget buildRecipeImge(Recipe recipe) {
  if (recipe.image != null && recipe.image.startsWith('https://')) {
    return Image.network(
      recipe.image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    );
  } else if (recipe.image != null && recipe.image.startsWith('assets/')) {
    return Image.asset(
      recipe.image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    );
  } else {
    return Image.asset(
      'assets/default_image.jpg',
      fit: BoxFit.cover,
      width: 200,
      height: 160,
    );
  }
}
