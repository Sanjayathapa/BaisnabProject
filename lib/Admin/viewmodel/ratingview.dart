import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_clippers/custom_clippers.dart';

class Rating {
  final String username;
  final String recipeTitle;
  final int rating;

  Rating({
    required this.username,
    required this.recipeTitle,
    required this.rating,
  });

  factory Rating.fromMap(Map<String, dynamic>? data) {
    return Rating(
      username: data?['username'] ?? '',
      recipeTitle: data?['recipeTitle'] ?? '',
      rating: data?['rating'] ?? 0,
    );
  }
}

class ratingscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 249, 220),
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 200, 229, 252),
        title: Text(
          'Rating list',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: ClipPath(
  clipper: LowerNipMessageClipper(
    MessageType.receive,
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 20), // Adjust as needed
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ratings').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        var ratings = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: ratings.length,
          itemBuilder: (context, index) {
            var ratingData = ratings[index].data() as Map<String, dynamic>;

            Rating rating = Rating.fromMap(ratingData);
           
            return ListTile(
              title: RichText( 
                text: TextSpan(
                  text: 'User: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '${rating.username}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Recipe: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: '${rating.recipeTitle}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Rating: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: '${rating.rating}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        );
      },
    ),
  ),
),


    );
  }
}
