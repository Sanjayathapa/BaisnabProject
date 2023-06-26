import 'package:baisnab/data/recipe1.dart';
import 'package:baisnab/multidimensional_array/screen/recipe.dart';
import 'package:baisnab/screens/recipe_types.dart/samosa.dart';
import 'package:flutter/material.dart';

// import '../screens/recipe_types/dosa.dart';
// import '../screens/recipe_types/ladu.dart';

myPro(BuildContext context,  String langu, String title,
    String star) {
  return GestureDetector(
     onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeMenuPage( 
            
             ),
          ),
        );
      
  // if (title == 'Dosa') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DosaPage(), // Replace with your desired page
  //     ),
  //   );
  // } else if (title == 'samosa and jaleby') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SamosaPage(), // Replace with your desired page
  //     ),
  //   );
  // } else if (title == 'Laduu') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => LaduuPage(), // Replace with your desired page
  //     ),
  //   );
  // } else if (title == 'momo,chaumin') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MomoPage(), // Replace with your desired page
  //     ),
  //   );
  // }else if (title == 'salda and raita') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MomoPage(), // Replace with your desired page
  //     ),
  //   );
  // }else if (title == 'Pasta and pizza') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => pastaPage(), // Replace with your desired page
  //     ),
  //   );

  // }else if (title == 'Roti,naan,parautha') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Rotinan (), // Replace with your desired page
  //     ),
  //   );
  // }
  // // Add more conditions for other card widgets if needed
},

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              shadowColor: Colors.tealAccent,
              color: const Color(0xFF47F873),
              child: ClipRRect(
                // margin: const EdgeInsets.only(left: 20, right: 10, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: AssetImage(
                          langu,
                        ),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 180),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),

                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        // Expanded(child: Container()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
}


