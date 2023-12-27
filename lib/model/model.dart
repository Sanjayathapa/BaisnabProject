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
  final double rating;
  final String description;
  final String image;

  Recipe({
    required this.recipeId,
    required this.recipeTitle,
    required this.recipename,
    required this.cookingTime,
    this.quantity = 1,
     required this.rating,
    required this.description,
    required this.image,
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
        quantity:data['quantity'],
      description: data['description'],
      image: data['image'],
    );
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      recipeId: map['recipeId'] as String,
      recipeTitle: map['recipeTitle'] as String,
      recipename: map['recipename'] != null ? (map['recipename'] as num).toDouble() : null,
      cookingTime: map['cookingTime'] as String,
        rating: map['rating'] as double,
      description: map['description'] as String,
      image: map['image'] as String,
       quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  expand(Function(dynamic recipeList) param0) {}

  toLowerCase() {}

  map(GestureDetector Function(dynamic recipe) param0) {}
}


