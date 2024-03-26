import 'package:baisnab/model/model.dart';
import 'package:baisnab/users/screens/menue.dart/recipiedetails.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class adddrecipeStatefulWidget extends StatefulWidget {
  
  final List<Recipe> recipes;

  const adddrecipeStatefulWidget({
    Key? key,
   
    required this.recipes,
  }) : super(key: key);

  @override
  _adddrecipeState createState() => _adddrecipeState();
}

class _adddrecipeState extends State<adddrecipeStatefulWidget> {
  final firestore = FirebaseFirestore.instance;

  final List<Recipe> favoriteRecipes = [];

  @override
  Future<void> showCustomDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recipe Added'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addRecipeToFavorites(BuildContext context, Recipe recipe) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      if (user != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final CollectionReference favoritesCollection =
            firestore.collection('favs').doc(user.uid).collection('fav');

        // Check if a recipe with the same recipeId already exists
        final QuerySnapshot existingRecipes = await favoritesCollection
            .where('recipeId', isEqualTo: recipe.recipeId)
            .get();

        if (existingRecipes.docs.isEmpty) {
          final double? recipename = recipe.recipename;

          final Map<String, dynamic> recipeMap = {
            'recipeId': recipe.recipeId,
            'recipeTitle': recipe.recipeTitle,
            'recipename': recipename,
            'cookingTime': recipe.cookingTime,
            'image': recipe.image,
            'index': recipe.index,
            'description': recipe.description,
          };

          await favoritesCollection.add(recipeMap);

          showCustomDialog('Recipe is added on Favorite Page ');
        } else {
          showCustomDialog('Recipe is already in Favorite Page');
        }
      }
    } catch (e) {
      print(e.toString());

      showCustomDialog('Failed to add on the  Favorite Page ');
    }
  }

  Widget build(BuildContext context) {
   
    return Scaffold(
        body: SafeArea(

          child: Row( 
              children: [ 
                Container(
        
              child:  Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('added').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator.adaptive();
                }
          
                if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
                }
          
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No data found.');
                }
          
                return ListView.builder(
                   scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final recipeItem = snapshot.data!.docs[index].data();
          
            if (recipeItem is Map<String, dynamic>) {
              final recipeId = recipeItem['recipeId'];
              final recipeTitle = recipeItem['recipeTitle'];
              final recipename = recipeItem['recipename'];
             dynamic index = recipeItem['index'];
              final double? recipenameAsDouble = recipename != null
                  ? (recipename as num).toDouble()
                  : null;
          
              final cookingTime = recipeItem['cookingTime'];
              final image = recipeItem['image'];
             final int indexAsInt = index is int ? index : int.tryParse(index.toString()) ?? 0;         
              final ratingValue = recipeItem['rating'];
              final double? rating = ratingValue != null
                  ? (ratingValue as num).toDouble()
                  : null;
          
              final quantityValue = recipeItem['quantity'];
              final int? quantity = quantityValue != null
                  ? (quantityValue as num).toInt()
                  : null;
          
              final description = recipeItem['description'];
          
              final recipe = Recipe(
                 recipeId: recipeId ?? '',
               recipeTitle: recipeTitle ?? '',
                recipename: recipenameAsDouble,
                cookingTime: cookingTime ?? '',
                image: image ?? '',
              index: indexAsInt,
                rating: rating ?? 4,
                quantity: quantity ?? 1,
                description: description ?? '',
              );
          
              return 
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetPage(
                        recipes:  [widget.recipes],
                        
                        recipe: recipe,
                      ),
                    ),
                  );
                },  
                            
                                      child:SizedBox(
                                        width: 150,
                                        // height:100,
                                        child: Card(
                                          
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          shadowColor: Color.fromARGB(255, 249, 46, 154),
                                          color: Color.fromARGB(255, 168, 1, 54),
                                          child: Padding(
                                            padding: const EdgeInsets.all(9.0),
                                           child: Column( crossAxisAlignment:  CrossAxisAlignment.start,
                                                    children: [
                                             
                                                
                                              
                                                buildRecipeImage(recipe),
                                                // Image.asset(
                                                //   recipe.image,
                                                //   fit: BoxFit.cover,
                                                //   width: 70,
                                                //   height: 80,
                                                // ),
                                                // const SizedBox(height: 10),
                                                
                                                      Text(
                                                        recipe.recipeTitle,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2.0),
                                                      Text(
                                                        'NRS ${recipe.recipename?.toStringAsFixed(2) ?? "0.00"}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                     
                                              Row(
                                            children: [
                                              Container(
                                                child: IconButton(
                                                  onPressed: () {
                                                    addRecipeToFavorites(context, recipe);
                                                  },
                                                  icon: const Icon(
                                                    Icons.favorite,
                                                    size: 14.0,
                                                    color: Color.fromARGB(255, 245, 235, 234),
                                                  ),
                                                ),
                                              ),
                                            const SizedBox(height: 4.0), // Adjust the height value
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 0.0, // Adjust the vertical padding value
                                            ),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                            ),
                                          ),
                                            ],
                                          ),
                                                                                        
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                               
                                
                                  
                                  
                   );
                        } else {
                         
                          print('Error: recipeItem is null');
                          return Container(); // Return an empty container or a placeholder widget
                        }
                      },
                        );
                  },
                ))
            ),
              ],
          ),
        ),
      
    );
  }
}

Widget buildRecipeImage(Recipe recipe) {
  if (recipe.image != null && recipe.image.startsWith('https://')) {
    // Image is a network image
    return Image.network(
      recipe.image,
      fit: BoxFit.cover,
     width: 150,
                        height: 80,
    );
  } else if (recipe.image != null && recipe.image.startsWith('assets/')) {
    // Image is from assets
    return Image.asset(
      recipe.image,
      fit: BoxFit.cover,
    width: 150,
   height: 80,
    );
  } else {
    return Image.asset(
      recipe.image, // Replace with your default image path
      fit: BoxFit.cover,
      width: 150,
      height: 80,
    );
  }
}

Future<String?> fetchImageFromFirestore(String recipeTitle) async {
  try {
    DocumentSnapshot recipeSnapshot = await FirebaseFirestore.instance
        .collection('added')
        .doc(recipeTitle)
        .get();

    if (recipeSnapshot.exists) {
      // Assuming the image URL is stored in the 'image' field
      return recipeSnapshot['image'] ?? '';
    } else {
      print('Recipe not found in Firestore');
      return null;
    }
  } catch (e) {
    print('Error fetching image from Firestore: $e');
    return null;
  }
}
