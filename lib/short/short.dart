import 'package:baisnab/model/model.dart';
import 'package:flutter/material.dart';
import '../data/recipelist.dart';
import '../screens/menue.dart/recipe1.dart';



// myPro(BuildContext context,  String langu, String title,
//     String star) {
//   return GestureDetector(
//      onTap: () {
//   if (title == 'Dosa') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DosaPage(), // Replace with your desired page
//       ),
//     );
//   } else if (title == 'samosa and jaleby') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SamosaPage(), // Replace with your desired page
//       ),
//     );
//   } else if (title == 'Laduu') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LaduuPage(), // Replace with your desired page
//       ),
//     );
//   } else if (title == 'momo,chaumin') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MomoPage(), // Replace with your desired page
//       ),
//     );
//   }else if (title == 'salad and raita') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => salad(), // Replace with your desired page
//       ),
//     );
//   }else if (title == 'Pasta and pizza') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => pastaPage(), // Replace with your desired page
//       ),
//     );

//   }else if (title == 'Roti,naan,parautha') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Rotinan(), // Replace with your desired page
//       ),
//     );
//   }else if (title == 'Tea and Coffee') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => teapage(), // Replace with your desired page
//       ),
//     );
//   }else if (title == 'Juice') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => juicepage(), // Replace with your desired page
//       ),
//     );
//   }
//   // Add more conditions for other card widgets if needed
// },
mypro(BuildContext context, int selectedIndex, String categoryName, List<List<Recipe>> recipes) {
  List<Recipe> selectedRecipes = recipes[selectedIndex]; // Get the selected list of recipes

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageeStatefulWidget(selectedIndex: selectedIndex, recipes: selectedRecipes)
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
                        selectedRecipes[0].image,
                        ),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 160),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                          categoryName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),

                      
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


