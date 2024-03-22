import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/gesture_detector.dart';



class User {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
    );
  }
}
class Order {
  final String username;
  final String address;
  final String email;
  final String phoneNumber;
  final String recipeTitle;
  final double recipePrice;
  final Timestamp timestamp;

  Order({
    required this.username,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.recipeTitle,
    required this.recipePrice,
    required this.timestamp,
  });
  factory Order.fromMap(Map<String, dynamic>? data) {
    return Order(
      username: data?['username'] ?? '',
      address: data?['address'] ?? '',
      email: data?['email'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      recipeTitle: data?['recipeTitle'] ?? '',
      recipePrice: data?['recipePrice']?.toDouble() ?? 0.0,
      timestamp: data?['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }
}
// order.dart

