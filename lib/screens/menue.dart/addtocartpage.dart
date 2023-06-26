
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToCartPage extends StatelessWidget {
  final Recipe recipe;

  const AddToCartPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Function to add recipe to Firestore
    Future<void> addToCart() async {
      try {
        await firestore.collection('cart').add(recipe.toMap());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe added to cart')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add recipe to cart')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Cart'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: addToCart,
          child: const Text('Add to Cart'),
        ),
      ),
    );
  }
}

class Recipe {
  final String recipeTitle;
  final String recipename;
  final String cookingTime;
  final String readingTime;
  final String description;
  final String image;

  Recipe({
    required this.recipeTitle,
    required this.recipename,
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

  // Create Recipe object from Firestore document snapshot
  factory Recipe.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Recipe(
      recipeTitle: data['recipeTitle'],
      recipename: data['recipename'],
      cookingTime: data['cookingTime'],
      readingTime: data['readingTime'],
      description: data['description'],
      image: data['image'],
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final List<Recipe> cartRecipes = snapshot.data!.docs
              .map((doc) => Recipe.fromSnapshot(doc))
              .toList();

          return ListView.builder(
            itemCount: cartRecipes.length,
            itemBuilder: (context, index) {
              final recipe = cartRecipes[index];
              return ListTile(
                title: Text(recipe.recipeTitle),
                subtitle: Text(recipe.description),
                leading: Image.asset(recipe.image),
              );
            },
          );
        },
      ),
    );
  }
}