import 'package:baisnab/model/model.dart';
import 'package:baisnab/users/theme.dart/theme.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/menue.dart/recipe1.dart';


Widget mypros(BuildContext context, int selectedIndex, String categoryName, List<List<Recipe>> recipes) {
  List<Recipe> selectedRecipes = recipes[selectedIndex]; 

  return GestureDetector(
    onTap: () {
       final containerColorProvider = Provider.of<ContainerColorProvider>(context, listen: false);
    if (containerColorProvider.isColorChanged) {
      containerColorProvider.resetColor();
    } else {
      containerColorProvider.setHoverColor();
    }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageeStatefulWidget(selectedIndex: selectedIndex, recipes: selectedRecipes),
        ),
      );
    },
    child: SingleChildScrollView(  
      scrollDirection: Axis.horizontal,
      child:Padding(
      padding: const EdgeInsets.all(8.0),
     
      child:
       ClipPath(
        clipper: OvalRightBorderClipper(),
            child: Consumer<ContainerColorProvider>(
          builder: (context, colorProvider, _) 
          {
            return Container(
           color: colorProvider.containerColor,
             width: 390,
             height:100,
          child: ListTile(
            title: Column(
              children: [
                SizedBox(
                
                  height: 90,
                  child: Container(
                  
                   
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 90, 255, 65), 
                              width: 2.0, 
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.0), 
                              child: Image.asset(
                                selectedRecipes[0].image,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 70,
                              ),
                            ),
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              categoryName,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 17, 3, 170),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    
                  ),
                ),
              ],
            ),
          ));
          },
        ),
      ),
      
    )));
  
}


