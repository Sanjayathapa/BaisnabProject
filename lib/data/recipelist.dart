
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';
// import 'dart:js';
class RecipeProvider with ChangeNotifier {
final List<List<Recipe>> recipes = [
  //////for dosa///////
  [
    
   
    Recipe(
      recipeId: '0',
      recipeTitle: "Masala dosa",
      recipename:240,
      cookingTime: "25 minutes",
      image: "assets/dosa/masala.png",
      rating: 4,
       quantity:1,
      description:
          "\nMasala dosa with chutney and sambar and potato sabzi.\n Dosa is a pancake from south India typically in Cone, \ntriangle or roll shape, selective focus",
    ),
    Recipe(
      recipeId: '1',
      recipeTitle: "Cheese masala Dosa",
      recipename: 320,
      cookingTime: "25 minutes",
      image: "assets/dosa/cheese.png",
      rating: 4,
      description:
          "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
    Recipe(
      recipeId: '2',
      recipeTitle: "Rawa onion masala Dosa",
      recipename:270,
      cookingTime: "30 minutes",
      image: "assets/dosa/rawaonion.png",
      rating: 4,
       quantity:1,
      description:
          "Rawa Onion Dosa is a popular South Indian dish made from semolina (rawa) batter mixed with onions and spices. \nIt is a quick and easy recipe that does not require fermentation like traditional dosa batter. \nThe dosa has a crispy texture and a delicious savory taste.\n It can be served as a breakfast or snack option, paired with coconut chutney or sambar.",
    ),
    Recipe(
      recipeId: '3',
      recipeTitle: "Baishnab Special Dosa",
      recipename:280,
      cookingTime: "30 minutes",
      image: "assets/dosa/special.png",
      rating: 4,
       quantity:1,
      description:
          " A special dosa filled with a flavorful mixture of paneer (Indian cottage cheese) and sautéed onions.\n The paneer adds a creamy and rich texture to the dosa, while the onions provide a sweet and savory taste.\n This dosa is perfect for breakfast or as a snack, and it pairs well with chutney or sambar.",
    ),
    Recipe(
      recipeId: '4',
      recipeTitle: " Onion Dosa",
      recipename :190,
      cookingTime: "20 minutes",
      image: "assets/dosa/onion.png",
      rating: 4,
       quantity:1,
      description:
          " Onion Dosa is a popular South Indian dish made with fermented rice and lentil batter mixed with onions and spices.\n It is a thin and crispy pancake-like dish that is typically served with chutney and sambar.",
    ),
    Recipe(
      recipeId: '5',
      recipeTitle: "Onion Masala Dosa",
      recipename: 270,
      cookingTime: "30 minutes",
      image: "assets/dosa/onionmasala.png",
      rating: 4,
       quantity:1,
      description:
          " it is a popular South Indian dish where a thin, crispy dosa is filled with a flavorful onion and potato masala stuffing. \nThe dosa is made by fermenting a batter of rice and lentils, which is then spread on a hot griddle and cooked until crispy.\n The onion masala filling is prepared by sautéing onions, spices, and boiled potatoes, resulting in a delicious and satisfying dish.",
    ),
    Recipe(
      recipeId: '6',
      recipeTitle: "cheese Dosa",
      recipename:  230,
      cookingTime: "20-30 minutes",
      rating: 4,
       quantity:1,
      image: "assets/dosa/special.png",
      description:
          " Cheese Dosa is made by spreading a thin layer of dosa batter \n on a hot griddle or tawa, and then sprinkling grated cheese on top.",
    ),
    Recipe(
      recipeId: '7',
      recipeTitle: " Paneer Dosa",
      recipename:320,
      cookingTime: "20 minutes",
      rating: 4,
       quantity:1,
      image: "assets/dosa/paneer.png",
      description:
          " Paneer Dosa is a popular variation of the traditional dosa, where the dosa is stuffed with a filling made of paneer, spices, and herbs.\n The paneer filling adds a creamy and rich texture to the dosa, making it a satisfying and flavorful dish.",
    ),
    Recipe(
      recipeId: '8',
      recipeTitle: "Plain Dosa",
      recipename:  170,
      cookingTime: "30 minutes",
      image: "assets/dosa/Plain-Dosa.jpg",
      rating: 4,
       quantity:1,
      description:
          "Plain dosa is a popular South Indian dish made from fermented rice and lentil batter. \nIt is a thin, crispy pancake-like crepe that is typically served with sambar (a lentil-based vegetable stew) and chutney..",
    ),
  ],
////////for samosa//////////
  [
    Recipe(
    recipeId: '9',
    recipeTitle: "Recipe 3",
    recipename:  300,
    cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
    image: "assets/images/pizza.jpeg",
    description: "Recipe 3 description",
  ),
  Recipe(
    recipeId: '10',
    recipeTitle: "Recipe 4",
    recipename: 400,
    cookingTime: "25 minutes",
   rating: 4,
    quantity:1,
    image: "assets/images/samosa.jpg",
    description: "Recipe 4 description",
  ),
  ],
////////for thali////
  [
Recipe(
      recipeId: '11',
    recipeTitle: "Baisnab Special Thali",
    recipename :550,
    cookingTime: "1 hour",
   rating: 4,
    quantity:1,
    image: "assets/thali/BaisanabSpecialThali.png",
    description: "Recipe 1 description",
  ),
    Recipe(recipeId: '12',
      recipeTitle: "Nepali Fixed Thali",
       recipename: 300,
      cookingTime: "50 minutes",
     rating: 4,
      quantity:1,
      image: "assets/thali/NepaliFixedThali.png",
     description: "",
    ),

  ],
//////for biryani //////
  [
   Recipe(
      recipeId: '13',
    recipeTitle: "Jeera Rice",
    recipename:210,
    cookingTime: "1 hour",
   rating: 4,
    quantity:1,
    image: "assets/pulav/JeeraRice.png",
    description: "",
  ),
    Recipe(recipeId: '14',
      recipeTitle: "Kashmiri Pulav",
       recipename: 340,
      cookingTime: "50 minutes",
     rating: 4,
      quantity:1,
      image: "assets/pulav/KashmiriPulav.png",
     description: "",
    ),
Recipe(
      recipeId: '15',
    recipeTitle: "Peas Pulav",
    recipename: 290,
    cookingTime: "1 hour",
   rating: 4,
    quantity:1,
    image: "assets/pulav/PeasPulav.png",
    description: "",
  ),
    Recipe(recipeId: '16',
      recipeTitle: "Plain Rice",
       recipename: 160,
      cookingTime: "50 minutes",
     rating: 4,
      quantity:1,
      image: "assets/pulav/PlainRice.png",
     description: "",
    ),
     Recipe(
      recipeId: '17',
    recipeTitle: "Veg Biryani",
    recipename: 320,
    cookingTime: "1 hour",
   rating: 4,
    quantity:1,
    image: "assets/pulav/VegBiryani.png",
    description: "",
  ),
    Recipe(recipeId: '18',
      recipeTitle: "Veg Pulav",
       recipename: 270,
      cookingTime: "50 minutes",
     rating: 4,
      quantity:1,
      image: "assets/pulav/vegpulav.png",
     description: "",
    ),
  ],
//////for roti nan////////
  [
Recipe(
      recipeId: '19',
    recipeTitle: "Aloo Piyaj Kulcha",
    recipename: 140,
    cookingTime: "20 minutes",
  rating: 4,
   quantity:1,
    image: "assets/roti/aloopyajkulcha.png",
    description: "",
  ),
   Recipe(recipeId: '20',
      recipeTitle: "Butter Nan",
       recipename: 80,
      cookingTime: "20 minutes",
      rating: 4,
       quantity:1,
      image: "assets/roti/butternan.png",
     description: "",
    ),
  Recipe(
     recipeId: '21',
    recipeTitle: "Cheese Chily Nan",
    recipename:  135,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/roti/cheesechillynan.png",
    description: "Recipe 1 description",
  ),
  Recipe(recipeId: '22',
      recipeTitle: "Cheese Garlic Nan",
       recipename: 140,
      cookingTime: "20 minutes",
     rating: 4,
      image: "assets/roti/cheesegarlicnan.png",
     description: "\ncheese masala dosa recipe with sambar and chutney, \nselective focus",
    ),
 Recipe(recipeId: '23',
      recipeTitle: "CheeseTomato Kulcha",
       recipename:  160,
      cookingTime: "20 minutes",
      rating: 4,
       quantity:1,
      image: "assets/roti/cheesetomatokulcha.png",
     description: "",
    ),
  Recipe(
     recipeId: '24',
    recipeTitle: "Garlic Nan",
    recipename:110,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/roti/garlicnan.png",
    description: "",
  ),
   Recipe(recipeId: '25',
      recipeTitle: "Gobi Paratha",
       recipename: 135,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/roti/gobiparatha.png",
     description: "",
    ),
     Recipe(recipeId: '26',
      recipeTitle: "Lacha Parautha",
       recipename: 135,
      cookingTime: "20 minutes",
      rating: 4,
       quantity:1,
      image: "assets/roti/lachaparautha.png",
     description: "",
    ),
     Recipe(recipeId: '27',
      recipeTitle: "Aaloo Parautha",
       recipename: 135,
      cookingTime: "20 minutes",
      rating: 4,
       quantity:1,
      image: "assets/roti/lachaparautha.png",
     description: "",
    ),
 Recipe(
     recipeId: '28',
    recipeTitle: "Missi Roti",
    recipename:140,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/roti/missiroti.png",
    description: "",
  ),
  Recipe(recipeId: '29',
      recipeTitle: "Plain Nan",
       recipename: 280,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/roti/plainnan.png",
     description: "",
    ),
    Recipe(
     recipeId: '30',
    recipeTitle: "Rumali Roti",
    recipename: 70,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/roti/rumaliroti.png",
    description: "",
  ),
  Recipe(recipeId: '31',
      recipeTitle: "Tandorri Roti",
       recipename:  280,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/roti/tandorriroti.png",
     description: "",
    ),
     Recipe(recipeId: '32',
      recipeTitle: "Veg Stuffed Kulcha",
       recipename: 140,
      cookingTime: "20 minutes",
      rating: 4,
       quantity:1,
      image: "assets/roti/vegstuffedkulcha.png",
     description: "",
    ),
  Recipe(
     recipeId: '33',
    recipeTitle: "Veg Stuffed Nan",
    recipename: 170,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/roti/vegstuffednan.png",
    description: "",
  ),

  ],
///// for laddu//////
  [
   Recipe(
      recipeId: '34',
    recipeTitle: "Anarkali Per piece",
    recipename :100,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/anartkaliperpiece.png",
    description: "Recipe 1 description",
  ),
   Recipe(recipeId: '35',
      recipeTitle: "Badam Bhog",
       recipename: 280,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/sweet/badambhog.png",
     description: "",
    ),
 Recipe(
     recipeId: '36',
    recipeTitle: "Recipe 1",
    recipename: 100,
    cookingTime: "10 minutes",
  rating: 4,
   quantity:1,
    image: "assets/images/idli.jpg",
    description: "Recipe 1 description",
  ),
   Recipe(recipeId: '37',
      recipeTitle: "Besan Masala Ladu",
       recipename: 280,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/sweet/besanmasalaladu.png",
     description: "",
    ),
  Recipe(
      recipeId: '38',
    recipeTitle: "burfiperpiece",
    recipename:100,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/burfiperpiece.png",
    description: "Recipe 1 description",
  ),
    Recipe(recipeId: '39',
      recipeTitle: "Cream Chamcham",
       recipename:  280,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/sweet/creamchamcham.png",
     description: "",
    ),
  Recipe(
     recipeId: '40',
    recipeTitle: "Ghee Laddu",
    recipename:100,
    cookingTime: "10 minutes",
  rating: 4,
   quantity:1,
    image: "assets/sweet/gheeladdu.png",
    description: "Recipe 1 description",
  ),
   Recipe(recipeId: '41',
      recipeTitle: "Gulab Jamun Per piece",
       recipename: 280,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/sweet/gulabjamunperpiece.png",
     description: "",
    ),
    Recipe(
      recipeId: '42',
    recipeTitle: "Kacha Gola",
    recipename:65,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/kachagola.png",
    description: "Recipe 1 description",
  ),
    Recipe(recipeId: '43',
      recipeTitle: "LalMohan Per piece",
       recipename: 40,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/sweet/lalmohanperpiece.png",
     description: "",
    ),
  Recipe(
     recipeId: '44',
    recipeTitle: "Malai Perpiece",
    recipename:100,
    cookingTime: "10 minutes",
  rating: 4,
   quantity:1,
    image: "assets/sweet/malaiperpiece.png",
    description: "Recipe 1 description",
  ),
Recipe(recipeId: '45',
      recipeTitle: "Milkcake",
       recipename: 60,
      cookingTime: "30 minutes",
     rating: 4,
      quantity:1,
      image: "assets/sweet/milkcake.png",
     description: "",
    ),
  Recipe(
      recipeId: '46',
    recipeTitle: "Peda Perpiece",
    recipename: 40,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/pedaperpiece.png",
    description: "Recipe 1 description",
  ),
 Recipe(recipeId: '47',
      recipeTitle: "Raj Bhog",
       recipename: 90,
      cookingTime: "30 minutes",
    rating: 4,
     quantity:1,
      image: "assets/sweet/rajbhog.png",
     description: "",
    ),
  Recipe(
     recipeId: '48',
    recipeTitle: "Rasbari 5 pieces",
    recipename:200,
    cookingTime: "30 minutes",
  rating: 4,
   quantity:1,
    image: "assets/sweet/rasbari5pieces.png",
    description: "Recipe 1 description",
  ),
   Recipe(recipeId: '49',
      recipeTitle: "Rasmalai 2 piece",
       recipename: 160,
      cookingTime: "30 minutes",
     rating: 4,
      quantity:1,
      image: "assets/sweet/rasdmalai2pieces.png",
     description: "",
    ),
  
  ],
  /////for burger////
  [
    Recipe(
      recipeId: '50',
    recipeTitle: "Club Sandwich",
    recipename:320,
    cookingTime: "15 minutes",
   rating: 4,
    quantity:1,
    image: "assets/burger/ClubSandwich.png",
    description: "",
  ),
   Recipe(recipeId: '51',
      recipeTitle: "ExoticContinental \n Sandwich",
       recipename:  320,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/burger/ExoticContinentalSandwich.png",
     description: "",
    ),
  Recipe(
      recipeId: '52',
    recipeTitle: "French Fries",
    recipename:170,
    cookingTime: "20 minutes",
   rating: 4,
    quantity:1,
    image: "assets/burger/FrenchFries.png",
    description: "",
  ),
   Recipe(recipeId: '53',
      recipeTitle: "Fruit Sandwich",
       recipename: 320,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/burger/FruitSandwich.png",
     description: "",
    ),
    Recipe(
      recipeId: '54',
    recipeTitle: "GarlicBread Sandwich",
    recipename:150,
    cookingTime: "20 minutes",
   rating: 4,
    quantity:1,
    image: "assets/burger/GarlicBreadSandwich.png",
    description: "",
  ),
    Recipe(recipeId: '55',
      recipeTitle: "PaneerChilly Burger",
       recipename: 260,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/burger/PaneerChillyBurger.png",
     description: "",
    ),
   Recipe(recipeId: '56',
      recipeTitle: "PaneerTikka Sandwich",
       recipename: 250,
      cookingTime: "30 minutes",
     rating: 4,
      quantity:1,
      image: "assets/burger/PaneerTikkaSandwich.png",
     description: "",
    ),
     Recipe(
      recipeId: '57',
    recipeTitle: "Veg Burger",
    recipename:320,
    cookingTime: "1 hour",
   rating: 4,
    quantity:1,
    image: "assets/burger/VegBurger.png",
    description: "",
  ),
   Recipe(recipeId: '58',
      recipeTitle: "VegSandwich",
       recipename: 270,
      cookingTime: "50 minutes",
     rating: 4,
      quantity:1,
      image: "assets/burger/VegSandwichWithCheese.png",
     description: "",
    ),
  ],
  ////// for pasta //////
[
Recipe(
      recipeId: '59',
    recipeTitle: "Veg Pasta Penna\n(RedSause)",
    recipename:350,
    cookingTime: "20 minutes",
   rating: 4,
    quantity:1,
    image: "assets/pasta/vegpastapenna(redsause).png",
    description: "",
  ),
   Recipe(recipeId: '60',
      recipeTitle: "Veg Pasta Penna\n(WhiteSause)",
       recipename: 300,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/pasta/vegpastapenna(whitesause).png",
     description: "",
    ),
  Recipe(
     recipeId: '61',
    recipeTitle: "Paneer Cheese Ball",
    recipename:300,
    cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
    image: "assets/pasta/paneercheeseball.png",
    description: "Recipe 1 description",
  ),

],
/////// for salad and raita////
[
Recipe(
      recipeId: '62',
    recipeTitle: "Chef Special Salad",
    recipename: 100,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/salad/chefspecialsalad.png",
    description: "Recipe 1 description",
  ),
   Recipe(recipeId: '63',
      recipeTitle: "Fruit Salad",
       recipename: 320,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/salad/fruitasalad.png",
     description: "",
    ),
  Recipe(
     recipeId: '64',
    recipeTitle: "Fruit Raita",
    recipename: 200,
    cookingTime: "10 minutes",
    rating: 4,
     quantity:1,
    image: "assets/salad/fruitraita.png",
    description: "Recipe 1 description",
  ),
   Recipe(recipeId: '65',
      recipeTitle: "Green Salad",
       recipename: 140,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/salad/greensalad.png",
     description: "",
    ),
     Recipe(recipeId: '66',
      recipeTitle: "Kachumbar Salad",
       recipename: 280,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/salad/MasalaKachumbarSalad.png",
     description: "",
    ),
  Recipe(
     recipeId: '67',
    recipeTitle: "Mix Raita",
    recipename:160,
    cookingTime: "10 minutes",
    rating: 4,
     quantity:1,
    image: "assets/salad/mixraita.png",
    description: "Recipe 1 description",
  ),
    Recipe(recipeId: '68',
      recipeTitle: "Onion Salad",
       recipename: 240,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/salad/onionsalad.png",
     description: "",
    ),
     Recipe(
     recipeId: '69',
    recipeTitle: "Pineapple Raita",
    recipename:180,
    cookingTime: "10 minutes" ,
     quantity:1,
    
    rating: 4,
    image: "assets/salad/pineappleraita.png",
    description: "Recipe 1 description",
  ),
    Recipe(recipeId: '70',
      recipeTitle: "Onion Salad",
       recipename: 260,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/salad/russiansalad.png",
     description: "",
    ),

],
///// for rasburry//////
  [ 
    Recipe(
     recipeId: '71',
    recipeTitle: "Rasbari 5 pieces",
    recipename:200,
    cookingTime: "30 minutes",
  rating: 4,
   quantity:1,
    image: "assets/sweet/rasbari5pieces.png",
    description: "Recipe 1 description",
  ),
   Recipe(
      recipeId: '72',
    recipeTitle: "Anarkali Per piece",
    recipename:  100,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/anartkaliperpiece.png",
    description: "Recipe 1 description",
  ),
   Recipe(recipeId: '73',
      recipeTitle: "Badam Bhog",
       recipename: 280,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/sweet/badambhog.png",
     description: "",
    ),
 
   
  Recipe(
      recipeId: '74',
    recipeTitle: "burfiperpiece",
    recipename:100,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/burfiperpiece.png",
    description: "Recipe 1 description",
  ),
    Recipe(recipeId: '75',
      recipeTitle: "Cream Chamcham",
       recipename: 280,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/sweet/creamchamcham.png",
     description: "",
    ),
 
   
    Recipe(
      recipeId: '76',
    recipeTitle: "Kacha Gola",
    recipename:65,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/kachagola.png",
    description: "Recipe 1 description",
  ),
    Recipe(recipeId: '77',
      recipeTitle: "LalMohan Per piece",
       recipename: 40,
      cookingTime: "20 minutes",
     rating: 4,
      quantity:1,
      image: "assets/sweet/lalmohanperpiece.png",
     description: "",
    ),
  Recipe(
     recipeId: '78',
    recipeTitle: "Malai Perpiece",
    recipename:100,
    cookingTime: "10 minutes",
  rating: 4,
   quantity:1,
    image: "assets/sweet/malaiperpiece.png",
    description: "Recipe 1 description",
  ),
Recipe(recipeId: '79',
      recipeTitle: "Milkcake",
       recipename: 60,
      cookingTime: "30 minutes",
     rating: 4,
      quantity:1,
      image: "assets/sweet/milkcake.png",
     description: "",
    ),
  Recipe(
      recipeId: '80',
    recipeTitle: "Peda Perpiece",
    recipename: 40,
    cookingTime: "10 minutes",
   rating: 4,
    quantity:1,
    image: "assets/sweet/pedaperpiece.png",
    description: "Recipe 1 description",
  ),
 Recipe(recipeId: '81',
      recipeTitle: "Raj Bhog",
       recipename: 90,
      cookingTime: "30 minutes",
    rating: 4,
     quantity:1,
      image: "assets/sweet/rajbhog.png",
     description: "",
    ),
 
   Recipe(recipeId: '82',
      recipeTitle: "Rasmalai 2 piece",
       recipename: 160,
      cookingTime: "30 minutes",
     rating: 4,
      quantity:1,
      image: "assets/sweet/rasdmalai2pieces.png",
     description: "",
    ),
  
  ],
  ////// for hot and cold beverage ////
  [
Recipe(
      recipeId: '83',
    recipeTitle: "Veg Pasta Penna\n(RedSause)",
    recipename:350,
    cookingTime: "20 minutes",
   rating: 4,
    quantity:1,
    image: "assets/pasta/vegpastapenna(redsause).png",
    description: "",
  ),
   Recipe(recipeId: '84',
      recipeTitle: "Veg Pasta Penna\n(WhiteSause)",
       recipename: 300,
      cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
      image: "assets/pasta/vegpastapenna(whitesause).png",
     description: "",
    ),
  Recipe(
     recipeId: '85',
    recipeTitle: "Paneer Cheese Ball",
    recipename:300,
    cookingTime: "20 minutes",
    rating: 4,
     quantity:1,
   
    image: "assets/pasta/paneercheeseball.png",
    description: "Recipe 1 description",
  ),

],
];
 Future<void> addRecipesToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      for (int i = 0; i < recipes.length; i++) {
        for (int j = 0; j < recipes[i].length; j++) {
          await firestore.collection('cart').add({
            'recipeId': recipes[i][j].recipeId,
            'recipeTitle': recipes[i][j].recipeTitle,
            'recipename': recipes[i][j].recipename,
            'cookingTime': recipes[i][j].cookingTime,
            'image': recipes[i][j].image,
            'rating': recipes[i][j].rating,
            'quantity': recipes[i][j].quantity,
            'description': recipes[i][j].description,
          });
        }
      }
    } catch (error) {
      print('Error adding recipes to Firestore: $error');
      // Handle the error as needed
    }
  }
  var recipe;
List<Recipe> getRecipeAtIndex(int index) {
    if (index >= 0 && index < recipes.length) {
      return recipes[index];
    } else {
      // Handle the case where the index is out of bounds
      return [];
    }
  }
// List<Recipe> get recipe => recipe;

  List<Recipe> _filteredRecipes = [];



  RecipeProvider(this.recipe) {
    _filteredRecipes.addAll(recipes.expand((list) => list));
  }

  List<Recipe> get filteredRecipes => _filteredRecipes;

  void filterRecipes(String query) {
    _filteredRecipes.clear();
    if (query.isEmpty) {
      _filteredRecipes.addAll(recipes.expand((list) => list));
    } else {
      for (var recipeList in recipes) {
        for (var recipe in recipeList) {
          if (recipe.recipeTitle.toLowerCase().contains(query.toLowerCase())) {
            _filteredRecipes.add(recipe);
          }
        }
      }
    }
    notifyListeners();
  }
//  double calculateTotalPrice() {
//   double totalPrice = 0.0;
//   for (var recipes in recipe) {
//     totalPrice += recipe.recipename; // Access the 'recipename' property of each Recipe
//   }
//   return totalPrice;
// }


}