import 'package:baisnab/data/recipelist.dart';
import 'package:baisnab/model/model.dart';
import 'package:baisnab/users/craud/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../data/recipelist.dart';
import '../screens/menue.dart/recipe1.dart';

class Recipes {
  final CollectionReference _cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Future<List<Recipe>> getRecipesFromFirestore(List<String> recipeIds) async {
    try {
      QuerySnapshot querySnapshot =
          await _cartCollection.where('recipeId', whereIn: recipeIds).get();

      return querySnapshot.docs
          .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }
   Future<String?> getImageUrl(String imagePath) async {
   
    return null;
  }
}

// mypro(BuildContext context, int selectedIndex, String categoryName,
//     List<List<Recipe>> recipes) {
//   List<Recipe> selectedRecipes =
//       recipes[selectedIndex]; // Get the selected list of recipes

//   return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => HomePageeStatefulWidget(
//                   selectedIndex: selectedIndex, recipes: selectedRecipes)),
//         );
//       },
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             Card(
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25.0)),
//               shadowColor: Colors.tealAccent,
//               color: Color.fromARGB(255, 235, 249, 239),
//               child: ClipRRect(
//                 // margin: const EdgeInsets.only(left: 20, right: 10, top: 40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image(
//                         image: AssetImage(
//                           selectedRecipes[0].image,
//                         ),
//                         fit: BoxFit.cover,
//                         width: 170,
//                         height: 160),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 10),
//                           child: Text(
//                             categoryName,
//                             style: const TextStyle(
//                                 color: Color.fromARGB(255, 30, 30, 30),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 3,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ));
// }

class AdminCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPressed;

  const AdminCard(
      {Key? key,
      required this.title,
      required this.image,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                image,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                    color: Color.fromARGB(255, 30, 30, 30),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
}
 Widget mypro(
    BuildContext context, int selectedIndex, String categoryName, List<List<Recipe>> recipes) {
  List<Recipe> selectedRecipes = recipes[selectedIndex];

  return FutureBuilder<QuerySnapshot>(
    // Use FutureBuilder to fetch data from Firestore
    future: FirebaseFirestore.instance.collection('cart').where('index', isEqualTo: selectedIndex).get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // If data is still loading, return a loading indicator or placeholder
        return CircularProgressIndicator();
      }

      if (snapshot.hasError) {
        // Handle any errors
        return Text('Error: ${snapshot.error}');
      }

      // Extract data from the snapshot
      var cartData = snapshot.data!.docs;

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePageeStatefulWidget(
                selectedIndex: selectedIndex,
                recipes: selectedRecipes,
              ),
            ),
          );
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                shadowColor: Colors.tealAccent,
                color: Color.fromARGB(255, 235, 249, 239),
                child: ClipRRect(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(selectedRecipes[0].image),
                        fit: BoxFit.cover,
                        width: 190,
                        height: 160,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Text(
                              categoryName,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 30, 30, 30),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}