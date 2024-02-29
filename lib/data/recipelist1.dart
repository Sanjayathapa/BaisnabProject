// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/model.dart';


// class RecipeProvider with ChangeNotifier {
//   final CollectionReference recipesCollection =
//       FirebaseFirestore.instance.collection('recipesCollection');

//  Future<void> addRecipesToFirestore(String category, List<Recipe> recipes) async {
//   DocumentReference categoryDoc = recipesCollection.doc(category);
//   CollectionReference categoryCollection = categoryDoc.collection(category);

//   try {
//     for (var recipe in recipes) {
//       await categoryCollection.add(recipe.toMap());
//     }
//     print('Recipes added successfully to Firestore under category $category');
//   } catch (e) {
//     print('Error adding recipes to Firestore: $e');
//   }
// }

// }

// void main() async {
//   RecipeProvider recipeProvider = RecipeProvider();

//   // Example of adding multiple dosa recipes to Firestore
//   List<Recipe> dosaRecipes = [
//     Recipe(
//       recipeId: '0',
//       recipeTitle: "Masala dosa",
//       recipename: 240,
//       cookingTime: "25 minutes",
//       image: "assets/dosa/masala.png",
//       rating: 4,
//       quantity: 1,
//       description:
//           "\nMasala dosa with chutney and sambar and potato sabzi.\n Dosa is a pancake from south India typically in Cone, \ntriangle or roll shape, selective focus",
//     ),
//     Recipe(
//       recipeId: '1',
//       recipeTitle: "Cheese masala Dosa",
//       recipename: 320,
//       cookingTime: "25 minutes",
//       image: "assets/dosa/cheese.png",
//       rating: 4,
//       quantity: 1,
//       description:
//           "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
//     ),
//     Recipe(
//       recipeId: '2',
//       recipeTitle: "Rawa onion masala Dosa",
//       recipename: 270,
//       cookingTime: "30 minutes",
//       image: "assets/dosa/rawaonion.png",
//       rating: 4,
//       quantity: 1,
//       description:
//           "Rawa Onion Dosa is a popular South Indian dish made from semolina (rawa) batter mixed with onions and spices. \nIt is a quick and easy recipe that does not require fermentation like traditional dosa batter. \nThe dosa has a crispy texture and a delicious savory taste.\n It can be served as a breakfast or snack option, paired with coconut chutney or sambar.",
//     ),
//   ];

//     try {
//     await recipeProvider.addRecipesToFirestore('dosa', dosaRecipes);
//     print('Adding dosa recipes to Firestore completed successfully.');
//   } catch (e) {
//     print('Error in adding dosa recipes to Firestore: $e');
//   }


//   // Example of adding multiple salad recipes to Firestore
//   List<Recipe> saladRecipes = [
//     Recipe(
//       recipeId: '0',
//       recipeTitle: "Caesar Salad",
//       recipename: 200,
//       cookingTime: "15 minutes",
//       image: "assets/salad/caesar.png",
//       rating: 4,
//       quantity: 1,
//       description: "Classic Caesar salad with fresh romaine lettuce, croutons, and parmesan cheese.",
//     ),
//     Recipe(
//       recipeId: '1',
//       recipeTitle: "Greek Salad",
//       recipename: 180,
//       cookingTime: "20 minutes",
//       image: "assets/salad/greek.png",
//       rating: 4,
//       quantity: 1,
//       description: "Healthy Greek salad with tomatoes, cucumbers, olives, feta cheese, and olive oil dressing.",
//     ),
//     Recipe(
//       recipeId: '2',
//       recipeTitle: "Caprese Salad",
//       recipename: 250,
//       cookingTime: "10 minutes",
//       image: "assets/salad/caprese.png",
//       rating: 4,
//       quantity: 1,
//       description: "Refreshing Caprese salad with tomatoes, fresh mozzarella, basil, and balsamic glaze.",
//     ),
//   ];

//   await recipeProvider.addRecipesToFirestore('salad', saladRecipes);
// }
