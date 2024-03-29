import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StarRating extends StatefulWidget {
  final int initialRating;
  final String username;
  final String recipeTitle;

  StarRating({
    required this.initialRating,
    required this.username,
    required this.recipeTitle,
  });

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _currentRating;
  int _ratingCount = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    fetchRatingCount(); // Fetch initial rating count
  }

  // Define a method to fetch the rating count
  void fetchRatingCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .where('username', isEqualTo: widget.username)
        .where('recipeTitle', isEqualTo: widget.recipeTitle)
        .get();

    setState(() {
      _ratingCount = querySnapshot.docs.length;
      // Fetch the current rating if it exists
      if (querySnapshot.docs.isNotEmpty) {
        _currentRating = querySnapshot.docs.first.get('rating');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final ratingValue = index + 1;
        return GestureDetector(
          onTap: () async {
            setState(() {
              _currentRating = ratingValue;
            });

            // Fetch existing rating document
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection('ratings')
                .where('username', isEqualTo: widget.username)
                .where('recipeTitle', isEqualTo: widget.recipeTitle)
                .get();

            // Check if the document exists
            if (querySnapshot.docs.isNotEmpty) {
              // Update existing rating
              String docId = querySnapshot.docs.first.id;
              FirebaseFirestore.instance
                  .collection('ratings')
                  .doc(docId)
                  .update({
                'rating': ratingValue,
                'timestamp': Timestamp.now(),
              }).then((value) {
                print("Rating updated successfully");
                // After updating, fetch rating count again
                fetchRatingCount();
              }).catchError((error) =>
                      print("Failed to update rating: $error"));
            } else {
              // Add new rating if document doesn't exist
              FirebaseFirestore.instance.collection('ratings').add({
                'username': widget.username,
                'recipeTitle': widget.recipeTitle,
                'rating': ratingValue,
                'timestamp': Timestamp.now(),
              }).then((value) {
                print("New rating added successfully");
                // After adding, fetch rating count again
                fetchRatingCount();
              }).catchError((error) =>
                      print("Failed to add new rating: $error"));
            }
          },
          child: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
        );
      }),
    );
  }
}
