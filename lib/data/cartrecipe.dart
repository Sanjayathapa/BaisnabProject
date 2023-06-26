// import 'package:flutter/material.dart';
// import '../screens/cartpage/cart.dart';
// final List<Recipes> recipes = [
//     Recipes(
//        recipeTitle: "Masala Dosa",
//       recipename: "240.0",

//       ),
//    Recipes(
//       recipeTitle: "Cheese Masala Dosa",
//        recipename: "280.0",

//        ),
//    Recipes(
//       recipeTitle: "Onion Dosa",
//      recipename: "220.0",

//     ),
//     Recipes(recipeTitle: "Paneer Dosa",
//      recipename: "280.0",

//       ),
//     Recipes(
//       recipeTitle: "Chicken Salad",
//      recipename: "180.0",

//     ),
//    Recipes(
//       recipeTitle: "Greek Salad",
//       recipename: "200.0",

//      ),
//    Recipes(
//       recipeTitle: "Caesar Salad",
//      recipename: "190.0",

//      ),
//   ];
class Recipe {
  final String recipeTitle;
  final String cookingTime;
  final String readingTime;
  final String description;
  final String image;

  Recipe({
    required this.recipeTitle,
    required this.cookingTime,
    required this.readingTime,
    required this.description,
    required this.image,
  });

  // Convert Recipe to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'recipeTitle': recipeTitle,
      'cookingTime': cookingTime,
      'readingTime': readingTime,
      'description': description,
      'image': image,
    };
  }
}
