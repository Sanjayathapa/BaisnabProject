

 import 'package:flutter/material.dart';

import '../screens/menue.dart/recipe1.dart';
import '../screens/recipe_types.dart/Rotinanparauthakulcha.dart';
import '../screens/recipe_types.dart/dosa.dart';
import '../screens/recipe_types.dart/hot_beverage.dart';
import '../screens/recipe_types.dart/juice.dart';
import '../screens/recipe_types.dart/ladu.dart';
import '../screens/recipe_types.dart/momo.dart';
import '../screens/recipe_types.dart/pastapizza.dart';
import '../screens/recipe_types.dart/salad.dart';
import '../screens/recipe_types.dart/samosa.dart';
//////for dosa/////
final List<Recipe> recipes = [
  Recipe(
    recipeId: '',
    recipeTitle: "Masala dosa",
    recipename: "NRS 240",
    cookingTime: "25 minutes",
   
    image: "assets/dosa/masala.png",
    description: "\nMasala dosa with chutney and sambar and potato sabzi.\n Dosa is a pancake from south India typically in Cone, \ntriangle or roll shape, selective focus",
  ),
  Recipe(
    recipeId: '',
    recipeTitle: "Cheese masala Dosa",
    recipename: "NRS 320",
    cookingTime: "25 minutes",
  
    image: "assets/dosa/cheese.png",
    description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
  ),
   Recipe(
    recipeId: '',
    recipeTitle: "Rawa onion masala Dosa",
    recipename: "NRS 270",
    cookingTime: "30 minutes",
    
    image: "assets/dosa/rawaonion.png",
    description: "Rawa Onion Dosa is a popular South Indian dish made from semolina (rawa) batter mixed with onions and spices. \nIt is a quick and easy recipe that does not require fermentation like traditional dosa batter. \nThe dosa has a crispy texture and a delicious savory taste.\n It can be served as a breakfast or snack option, paired with coconut chutney or sambar.",
  ),
  Recipe(
    recipeId: '',
    recipeTitle: "Baishnab Special Dosa",
    recipename: "NRS 280",
    cookingTime: "30 minutes",
   
    image: "assets/dosa/special.png",
    description: " A special dosa filled with a flavorful mixture of paneer (Indian cottage cheese) and sautéed onions.\n The paneer adds a creamy and rich texture to the dosa, while the onions provide a sweet and savory taste.\n This dosa is perfect for breakfast or as a snack, and it pairs well with chutney or sambar.",
  ),
    Recipe(
    recipeId: '',
    recipeTitle: " Onion Dosa",
    recipename: "NRS 190",
    cookingTime: "20 minutes",
    
    image: "assets/dosa/onion.png",
    description: " Onion Dosa is a popular South Indian dish made with fermented rice and lentil batter mixed with onions and spices.\n It is a thin and crispy pancake-like dish that is typically served with chutney and sambar.",
  ),
  Recipe(
    recipeId: '',
    recipeTitle: "Onion Masala Dosa",
    recipename: "NRS 270",
    cookingTime: "30 minutes",
   
    image: "assets/dosa/onionmasala.png",
    description: " it is a popular South Indian dish where a thin, crispy dosa is filled with a flavorful onion and potato masala stuffing. \nThe dosa is made by fermenting a batter of rice and lentils, which is then spread on a hot griddle and cooked until crispy.\n The onion masala filling is prepared by sautéing onions, spices, and boiled potatoes, resulting in a delicious and satisfying dish.",
  ),
  Recipe(
    recipeId: '',
    recipeTitle: "cheese Dosa",
    recipename: "NRS 230",
    cookingTime: "20-30 minutes",
   
    image: "assets/dosa/special.png",
    description: " Cheese Dosa is made by spreading a thin layer of dosa batter \n on a hot griddle or tawa, and then sprinkling grated cheese on top.",
  ),
    Recipe(
    recipeId: '',
    recipeTitle: " Paneer Dosa",
    recipename: "NRS 320",
    cookingTime: "20 minutes",
    
    image: "assets/dosa/paneer.png",
    description: " Paneer Dosa is a popular variation of the traditional dosa, where the dosa is stuffed with a filling made of paneer, spices, and herbs.\n The paneer filling adds a creamy and rich texture to the dosa, making it a satisfying and flavorful dish.",
  ), 
  Recipe(
    recipeId: '',
    recipeTitle: "Plain Dosa",
    recipename: "NRS 170",
    cookingTime: "30 minutes",
    
    image: "assets/dosa/Plain-Dosa.jpg",
    description: "Plain dosa is a popular South Indian dish made from fermented rice and lentil batter. \nIt is a thin, crispy pancake-like crepe that is typically served with sambar (a lentil-based vegetable stew) and chutney..",
  ),
];

List<Recipe> recipeList1 = [
  Recipe(
    recipeId: '',
    recipeTitle: "Plain Dosa",
    recipename: "NRS 270",
    cookingTime: "30 minutes",
    
    image: "assets/dosa/Plain-Dosa.jpg",
    description: "Plain dosa is a popular South Indian dish made from fermented rice and lentil batter. \nIt is a thin, crispy pancake-like crepe that is typically served with sambar (a lentil-based vegetable stew) and chutney..",
  ),
  Recipe(
    recipeId: '',
    recipeTitle: "Baishnab Special Dosa",
    recipename: "NRS 400",
    cookingTime: "30 minutes",
   
    image: "assets/dosa/special.png",
    description: " A special dosa filled with a flavorful mixture of paneer (Indian cottage cheese) and sautéed onions.\n The paneer adds a creamy and rich texture to the dosa, while the onions provide a sweet and savory taste.\n This dosa is perfect for breakfast or as a snack, and it pairs well with chutney or sambar.",
  ),
];
///for samosa/////////////
/////////
///
List<FoodIte> food = [
  FoodIte(
    recipeId: '',
    recipeTitle: "Recipe 3",
    recipename: "NRS 300",
    cookingTime: "20 minutes",
    readingTime: "10 minutes",
    image: "assets/images/pizza.jpeg",
    description: "Recipe 3 description",
  ),
  FoodIte(
    recipeId: '',
    recipeTitle: "Recipe 4",
    recipename: "NRS 400",
    cookingTime: "25 minutes",
    readingTime: "12 minutes",
    image: "assets/images/samosa.jpg",
    description: "Recipe 4 description",
  ),
];
///////for dosa/////////
/////////
 final List<FoodItem> foodItems = [
   FoodItem(
    recipeId: '',
    recipeTitle: "Masala dosa",
    recipename: "NRS 240",
    cookingTime: "25 minutes",
   
    image: "assets/dosa/masala.png",
    description: "\nMasala dosa with chutney and sambar and potato sabzi.\n Dosa is a pancake from south India typically in Cone, \ntriangle or roll shape, selective focus",
  ),
  FoodItem(
    recipeId: '',
    recipeTitle: "Cheese masala Dosa",
    recipename: "NRS 320",
    cookingTime: "25 minutes",
  
    image: "assets/dosa/cheese.png",
    description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
  ),
  FoodItem(
    recipeId: '',
    recipeTitle: "Rawa onion masala Dosa",
    recipename: "NRS 270",
    cookingTime: "30 minutes",
    
    image: "assets/dosa/rawaonion.png",
    description: "Rawa Onion Dosa is a popular South Indian dish made from semolina (rawa) batter mixed with onions and spices. \nIt is a quick and easy recipe that does not require fermentation like traditional dosa batter. \nThe dosa has a crispy texture and a delicious savory taste.\n It can be served as a breakfast or snack option, paired with coconut chutney or sambar.",
  ),
  FoodItem(
    recipeId: '',
    recipeTitle: "Baishnab Special Dosa",
    recipename: "NRS 280",
    cookingTime: "30 minutes",
   
    image: "assets/dosa/special.png",
    description: " A special dosa filled with a flavorful mixture of paneer (Indian cottage cheese) and sautéed onions.\n The paneer adds a creamy and rich texture to the dosa, while the onions provide a sweet and savory taste.\n This dosa is perfect for breakfast or as a snack, and it pairs well with chutney or sambar.",
  ),
   FoodItem(
    recipeId: '',
    recipeTitle: " Onion Dosa",
    recipename: "NRS 190",
    cookingTime: "20 minutes",
    
    image: "assets/dosa/onion.png",
    description: " Onion Dosa is a popular South Indian dish made with fermented rice and lentil batter mixed with onions and spices.\n It is a thin and crispy pancake-like dish that is typically served with chutney and sambar.",
  ),
 FoodItem(
    recipeId: '',
    recipeTitle: "Onion Masala Dosa",
    recipename: "NRS 270",
    cookingTime: "30 minutes",
   
    image: "assets/dosa/onionmasala.png",
    description: " it is a popular South Indian dish where a thin, crispy dosa is filled with a flavorful onion and potato masala stuffing. \nThe dosa is made by fermenting a batter of rice and lentils, which is then spread on a hot griddle and cooked until crispy.\n The onion masala filling is prepared by sautéing onions, spices, and boiled potatoes, resulting in a delicious and satisfying dish.",
  ),
  FoodItem(
    recipeId: '',
    recipeTitle: "cheese Dosa",
    recipename: "NRS 230",
    cookingTime: "20-30 minutes",
   
    image: "assets/dosa/special.png",
    description: " Cheese Dosa is made by spreading a thin layer of dosa batter \n on a hot griddle or tawa, and then sprinkling grated cheese on top.",
  ),
    FoodItem(
    recipeId: '',
    recipeTitle: " Paneer Dosa",
    recipename: "NRS 320",
    cookingTime: "20 minutes",
    
    image: "assets/dosa/paneer.png",
    description: " Paneer Dosa is a popular variation of the traditional dosa, where the dosa is stuffed with a filling made of paneer, spices, and herbs.\n The paneer filling adds a creamy and rich texture to the dosa, making it a satisfying and flavorful dish.",
  ), 
  FoodItem(
    recipeId: '',
    recipeTitle: "Plain Dosa",
    recipename: "NRS 170",
    cookingTime: "30 minutes",
    
    image: "assets/dosa/Plain-Dosa.jpg",
    description: "Plain dosa is a popular South Indian dish made from fermented rice and lentil batter. \nIt is a thin, crispy pancake-like crepe that is typically served with sambar (a lentil-based vegetable stew) and chutney..",
  ),
  ];
  /////for Momo///////////
  List<ListItem> foodItems1 = [
  ListItem(
   recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
    ListItem(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
 ListItem(
     recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   ListItem(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  // more FoodItem objects
];
/////for pastapizza ///////
List<RecipeItem> foodItems2 = [
RecipeItem(
      recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
    RecipeItem(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  RecipeItem(
     recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   RecipeItem(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  
  // more FoodItem objects
];

////&******** for rotinanparautharecipe////////*****
///
///
///
/// */
List<RecipeIte> foodItems3 = [
RecipeIte(
      recipeId: '',
    recipeTitle: "Aloo Piyaj Kulcha",
    recipename: "NRS 140",
    cookingTime: "20 minutes",
  
    image: "assets/roti/aloopyajkulcha.png",
    description: "",
  ),
    RecipeIte(recipeId: '',
      recipeTitle: "Butter Nan",
       recipename: " NRS 80",
      cookingTime: "20 minutes",
      
      image: "assets/roti/butternan.png",
     description: "",
    ),
  RecipeIte(
     recipeId: '',
    recipeTitle: "Cheese Chily Nan",
    recipename: "NRS 135",
    cookingTime: "10 minutes",
   
    image: "assets/roti/cheesechillynan.png",
    description: "Recipe 1 description",
  ),
   RecipeIte(recipeId: '',
      recipeTitle: "Cheese Garlic Nan",
       recipename: " NRS 140",
      cookingTime: "20 minutes",
     
      image: "assets/roti/cheesegarlicnan.png",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
   RecipeIte(recipeId: '',
      recipeTitle: "Cheese Tomato Kulcha",
       recipename: " NRS 160",
      cookingTime: "20 minutes",
      
      image: "assets/roti/cheesetomatokulcha.png",
     description: "",
    ),
  RecipeIte(
     recipeId: '',
    recipeTitle: "Garlic Nan",
    recipename: "NRS 110",
    cookingTime: "10 minutes",
   
    image: "assets/roti/garlicnan.png",
    description: "",
  ),
   RecipeIte(recipeId: '',
      recipeTitle: "Gobi Paratha",
       recipename: " NRS 135",
      cookingTime: "20 minutes",
     
      image: "assets/roti/gobiparatha.png",
     description: "",
    ),
     RecipeIte(recipeId: '',
      recipeTitle: "Lacha Parautha",
       recipename: " NRS 135",
      cookingTime: "20 minutes",
      
      image: "assets/roti/lachaparautha.png",
     description: "",
    ),
     RecipeIte(recipeId: '',
      recipeTitle: "Aaloo Parautha",
       recipename: " NRS 135",
      cookingTime: "20 minutes",
      
      image: "assets/roti/lachaparautha.png",
     description: "",
    ),
  RecipeIte(
     recipeId: '',
    recipeTitle: "Missi Roti",
    recipename: "NRS 140",
    cookingTime: "10 minutes",
   
    image: "assets/roti/missiroti.png",
    description: "",
  ),
   RecipeIte(recipeId: '',
      recipeTitle: "Plain Nan",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
     
      image: "assets/roti/plainnan.png",
     description: "",
    ),
    RecipeIte(
     recipeId: '',
    recipeTitle: "Rumali Roti",
    recipename: "NRS 70",
    cookingTime: "10 minutes",
   
    image: "assets/roti/rumaliroti.png",
    description: "",
  ),
   RecipeIte(recipeId: '',
      recipeTitle: "Tandorri Roti",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
     
      image: "assets/roti/tandorriroti.png",
     description: "",
    ),
     RecipeIte(recipeId: '',
      recipeTitle: "Veg Stuffed Kulcha",
       recipename: " NRS 140",
      cookingTime: "20 minutes",
      
      image: "assets/roti/vegstuffedkulcha.png",
     description: "",
    ),
  RecipeIte(
     recipeId: '',
    recipeTitle: "Veg Stuffed Nan",
    recipename: "NRS 170",
    cookingTime: "10 minutes",
   
    image: "assets/roti/vegstuffednan.png",
    description: "",
  ),
  
];
///////************8 for sald item  *///
///////
/////
///
List<RecipeIt> foodItems4 = [
RecipeIt(
      recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
    RecipeIt(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  RecipeIt(
     recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   RecipeIt(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  
  // more FoodItem objects
];

 ////************************** */
 ///**********************
 ///for laddu items */
 List<RecipeI> foodItems5 = [
RecipeI(
      recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
    RecipeI(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  RecipeI(
     recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   RecipeI(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  
  // more FoodItem objects
];
////&******** for Hot beverage reccipe////////*****
///
///
///
/// */
 List<Contained> foodItems6 = [
Contained(
      recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   Contained(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  Contained(
     recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   Contained(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  
  // more FoodItem objects
];
  ////&******** for Hot beverage reccipe////////*****
///
///
///
/// */
 List< Contain> foodItems7 = [
 Contain(
      recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
    Contain(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  Contain(
     recipeId: '',
    recipeTitle: "Recipe 1",
    recipename: "NRS 100",
    cookingTime: "10 minutes",
    readingTime: "5 minutes",
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   Contain(recipeId: '',
      recipeTitle: "Cheese masala",
       recipename: " NRS 280",
      cookingTime: "20 minutes",
      readingTime: "6 minutes",
      image: "assets/images/idli.jpg",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
  
  // more FoodItem objects
];
// final List<Recipe> recipes  = [
//     Recipe(
//       recipeId: '',
//       recipeTitle: "Masala dosa",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//       description: "\nMasala dosa with chutney and sambar and potato sabzi.\n Dosa is a pancake from south India typically in Cone, \ntriangle or roll shape, selective focus",
      
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Cheese masala",
//       recipename: " NRS 280",
//       cookingTime: "20 minutes",
//       readingTime: "6 minutes",
//       image: "assets/images/idli.jpg",
//      description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
//     ),
//     Recipe(
//       recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/Chole-Bhature.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/pizza.jpeg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//     description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//       description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//       description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//     description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//     description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//       description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//       description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "NRS 240",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "rs200",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "rs200",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(
//       recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "rs200",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//       description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "rs200",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "rs200",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//     Recipe(recipeId: '',
//       recipeTitle: "Greek Salad",
//       recipename: "rs200",
//       cookingTime: "15 minutes",
//       readingTime: "5 minutes",
//       image: "assets/images/food2.jpg",
//      description: "",
//     ),
//   ];