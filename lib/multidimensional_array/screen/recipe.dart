import 'package:baisnab/screens/menue.dart/recipe1.dart';
import 'package:baisnab/screens/menue.dart/recipedetails.dart';
import 'package:flutter/material.dart';

import '../data/multi.dart';

class FoodItem {
  final String name;
  final IconData icon;
  final IconData iconss;
  final IconData icone;
  final String imageAssets;
  final String ruppes;

  FoodItem(
      {required this.name,
      required this.icon,
      required this.ruppes,
      required this.imageAssets,
      required this.iconss,
      required this.icone});
}

class RecipeMenuPage extends StatelessWidget {


  RecipeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold
    (
      appBar: AppBar(
        title: const Text('Recipe Menu'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final foodItem = foodItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsPage(foodItem: foodItem),
                ),
              );
            },
            child: Card(
              color: const Color(0xFFF5F5FF),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      foodItem.imageAssets,
                      width: 200,
                      height: 130,
                      fit: BoxFit.cover,
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          const SizedBox(height: 8.0),
                          Text(
                            foodItem.name,
                            style: const TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            foodItem.ruppes,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                foodItem.icon,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              Icon(
                                foodItem.icon,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              Icon(
                                foodItem.icon,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              Icon(
                                foodItem.icon,
                                color: Colors.yellow,
                                size: 18,
                              ),
                            ],
                          ),
                          const SizedBox(width: 8.0),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                foodItem.iconss,
                                color: Colors.redAccent,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(foodItem.icone))
                    //     child:Icon(

                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}

class RecipeDetailsPage extends StatelessWidget {
  final FoodItem foodItem;

  const RecipeDetailsPage({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem.name),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              foodItem.imageAssets,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Recipe Details',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text('Add your recipe details here.'),
            ElevatedButton(
                onPressed: () {
                  var index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => 
                      CartPage(context: context, 
                       
                      ),
                    ),
                  );
                },
                child: const Text('click here to add on cart'))
          ],
        ),
      ),
    );
  }
}
