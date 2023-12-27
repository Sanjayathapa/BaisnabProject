import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/gesture_detector.dart';
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
}

///// for user list 

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