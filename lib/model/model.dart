import 'dart:convert';
// import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/gesture_detector.dart';

class Recipe {

  final String recipeId;
  final String recipeTitle;
  double? recipename;
  final String cookingTime;
  final int quantity;
    final int index;
 final bool isOutOfStock; 
  final double rating;
  final String description;
  final String image;
 final List<String> ingredients;
  Recipe({
    required this.recipeId,
    required this.recipeTitle,
    required this.recipename,
    required this.cookingTime,
    this.quantity = 1,
     required this.index,
     required this.rating,
    required this.description,
    required this.image,
     this.isOutOfStock = false,
      required this.ingredients,
  });

  get initialPrice => null;

  // Convert Recipe to a map for Firestore
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recipeId': recipeId,
      'recipeTitle': recipeTitle,
      'recipename': recipename,
      'cookingTime': cookingTime,
      'quantity': quantity,
      'description': description,
      'image': image,
      'isOutOfStock': isOutOfStock,
       'ingredients': ingredients,

    };
  }

  // Create Recipe object from Firestore document snapshot
  factory Recipe.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Recipe(
      recipeId: data['recipeId'],
      recipeTitle: data['recipeTitle'],
      recipename: data['recipename'],
      cookingTime: data['cookingTime'],
        rating: data['rating'],
         index: data['index'],
        quantity:data['quantity'],
      description: data['description'],
      image: data['image'],
      isOutOfStock: data['isOutOfStock'] ?? false,
        ingredients: List<String>.from(data['ingredients'] ?? []),
    );
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      recipeId: map['recipeId'] as String,
      recipeTitle: map['recipeTitle'] as String,
      recipename: map['recipename'] != null ? (map['recipename'] as num).toDouble() : null,
      cookingTime: map['cookingTime'] as String,
        rating: map['rating'] as double,
        index: map['index'] as int,
      description: map['description'] as String,
      image: map['image'] as String,
       quantity: map['quantity'] as int,
        isOutOfStock: map['isOutOfStock'] ?? false,
          ingredients: List<String>.from(map['ingredients'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  expand(Function(dynamic recipeList) param0) {}

  toLowerCase() {}

  map(GestureDetector Function(dynamic recipe) param0) {}

  data() {}
}


