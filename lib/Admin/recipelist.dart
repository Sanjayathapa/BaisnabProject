import 'package:baisnab/Admin/addrecipe.dart';
import 'package:baisnab/Admin/orderlist.dart';
import 'package:baisnab/Admin/edit.dart';
import 'package:baisnab/Admin/inner_screens/all_orders.dart';
import 'package:baisnab/Admin/inner_screens/edit_prod.dart';
import 'package:baisnab/Admin/recipedetails.dart';
import 'package:baisnab/Admin/userlist.dart';

import 'package:baisnab/model/model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AdminRecipeList extends StatelessWidget {
  Future<Recipe?> fetchData(String recipeTitle, String recipeId) async {
    try {
      print('Fetching data for recipe title: $recipeTitle');
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('recipeTitle', isEqualTo: recipeTitle)
          .where('recipeId', isEqualTo: recipeId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot recipeSnapshot = querySnapshot.docs.first;
        Map<String, dynamic> recipeData = recipeSnapshot.data() as Map<String, dynamic>;
        return Recipe.fromMap(recipeData); // Assuming you have a Recipe class
      } else {
        throw Exception('Recipe not found');
      }
    } catch (e, stackTrace) {
      print('Error fetching recipe: $e');
      print('StackTrace: $stackTrace');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe List"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Order List'),
              onTap: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>OrderListScreen ()
                              ),
                            );
              },
            ),
            ListTile(
              title: Text('User List'),
              onTap: () {
               Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserListScreen()
                              ),
                            );
              },
            ),
            ListTile(
              title: Text('Add Recipe'),
              onTap: () {
                 Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddRecipeScreen()
                              ),
                            );
                // Handle Add Recipe tap
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final cartItems = snapshot.data?.docs ?? [];

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index].data() as Map<String, dynamic>;
                final recipeTitle = (cartItem['recipeTitle'] as String?) ?? 'No Title';
                final recipenameField = cartItem['recipename'];
                final recipename =
                    (recipenameField is num) ? recipenameField.toDouble() : 0.0;
                final image = cartItem['image'] as String? ?? '';

                return GestureDetector(
                              onTap: () async {
                String recipeId = cartItem['recipeId'] as String? ?? '';
                String recipeTitle = cartItem['recipeTitle'] as String? ?? '';

                // Fetching data
                Recipe? selectedRecipe = await fetchData(recipeTitle, recipeId);

                if (selectedRecipe != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsPage(recipeTitle: recipeTitle),
                    ),
                  );
                } else {
                  print('Recipe not found');
                }
              },

                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 480,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          shadowColor: Colors.tealAccent,
                          color: const Color(0xFFF4F5FE),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 80,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        recipeTitle,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'NRS ${(recipename ?? 0.0).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          SizedBox(width: 8.0),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
