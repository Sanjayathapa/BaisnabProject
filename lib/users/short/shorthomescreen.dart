import 'package:baisnab/model/model.dart';
import 'package:flutter/material.dart';
// import 'dart:js';
// import '../data/recipelist.dart';
import '../screens/menue.dart/recipe1.dart';
  mypros(BuildContext context, int selectedIndex, String categoryName, List<List<Recipe>> recipes) {
  List<Recipe> selectedRecipes = recipes[selectedIndex]; // Get the selected list of recipes

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
         builder: (context) =>HomePageeStatefulWidget(selectedIndex: selectedIndex, recipes: selectedRecipes)
          // builder: (context) =>HomePagee(selectedIndex: selectedIndex, recipes: selectedRecipes),
        ),
      );
    },
    child: SingleChildScrollView(  
      scrollDirection: Axis.horizontal,
      child: Container(
         width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 110,
              child: Card( 
               
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
             shadowColor: Colors.tealAccent,
              color: const Color(0xFFF4F5FE),
                child: ClipRRect(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      
                      Image.asset(
                        selectedRecipes[0].image, // Access the image from selectedRecipes
                        fit: BoxFit.cover,
                        width: 70,
                        height: 75,
                      ),
        
                           Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                         child: Text(
                            categoryName,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 14, 14, 14),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),),
                        ]),
                  )),)
            ],
          ),
      ),
      ),
    );
  }

  

