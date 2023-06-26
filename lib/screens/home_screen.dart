import 'package:baisnab/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../data/recipe1.dart';
import '../slider/CarouselSlider.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:endless/endless.dart';
import '../search/list.dart';
import '../short/short.dart';
import 'menue.dart/recipe.dart';
import 'menue.dart/recipe1.dart';

class HomeScreen extends StatefulWidget {
  final List recipeMenu;
  final String title;
  
  const HomeScreen({Key? key, required this.title, required this.recipeMenu})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;



  @override
  Widget build(BuildContext context) {
   RecipePager pager = RecipePager(searchLists: []);

    Recipe recipe;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FEF4),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: IconButton(
                              icon: const Icon(
                                Icons.logout,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                    ]),
                Column(children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.red, Colors.blue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Welcome to our Baisnab sweets",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ]),
                 Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    CarouselSliderWidget(),
                  ],
                ),
               Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 380,
        child: PaginatedSearchBar<Recipe>(
          maxHeight: 300,
          hintText: 'Search',
          emptyBuilder: (context) {
            return const Text("I'm an empty state!");
          },
          paginationDelegate: EndlessPaginationDelegate(
            pageSize: 20,
            maxPages: 3,
          ),
          onSearch: ({
            required pageIndex,
            required pageSize,
            required searchQuery,
          }) async {
            return Future.delayed(const Duration(milliseconds: 2300), () {
              if (searchQuery == "empty") {
                return [];
              }

              if (pageIndex == 0) {
                pager = RecipePager(
                  searchLists: [
                    foodItems3,
                    foodItems4,
                    foodItems5,
                    foodItems6,
                    foodItems7,
                    foodItems2,
                    foodItems1,
                    foodItems,
                    food,
                    recipeList1,
                    recipes,
                  ],
                );
              }

              List<Recipe> searchResults = [];

              for (int i = 0; i < pageSize; i++) {
                List<dynamic> batch = pager.nextBatch();

                for (var item in batch) {
                  if (item is Recipe &&
                      item.recipeTitle
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase())) {
                    searchResults.add(item);
                  }
                }
              }

              return searchResults;
            });
          },
          itemBuilder: (context, {required item, required index}) {
            return GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>  RecipeDetPage( 
              //        recipe:recipes['recipe'], recipes: [],
              //        ),
              //     ),
              //   );
              // },
              child: ListTile(
                title: Text(item.recipeTitle),
                // Other ListTile properties
              ),
            );
          },
        ),
      ),
    ),
  ],
),

                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Our foods and sweets product',
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      //  GoogleFonts.lato
                    ),],
                ),
                    const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  
                    Text(
                      'Breakfast Item',
                      // GoogleFonts.lato
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                     textAlign: TextAlign.start,
                    ),
                  
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      

                      myPro(context,'assets/images/dosa.jpg', 'Dosa', '60',),
                      myPro(context,'assets/images/jaleby.jpg', 'samosa and jaleby', '20'),
                      myPro(context,'assets/roti/vegstuffednan.png', 'Roti,naan,parautha', '1'),
                     
                      myPro(context,'assets/images/thali.jpg', 'Thali', '10'),
                    
                      // })
                    ],
                  ),
                ),]),
                const SizedBox(height: 20),
                Text(
                  'Sweet Items', 
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    // GoogleFonts.lato
                    fontWeight: FontWeight.bold,
                  ),
                 
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                   
                      myPro(context,'assets/images/laduu.jpg', 'Laduu', '10'),
                      myPro(context,'assets/images/jaleby.jpg', 'Pasta and pizza', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'salad and raita', '10'),
                       myPro(context,'assets/images/rasburry.jpg', 'Rasburry ', '1'),
                      
                    ],
                  ),
                ),
                 const SizedBox(height: 20),
                 Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                Text(
                  'Roti,Naan,Paratha,kulcha',
                   textAlign: TextAlign.start,
                  style:TextStyle (
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  // GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Click 2 Coder', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Click 2', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),]),
                 const SizedBox(height: 20),
                 Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                Text(
                  'Hot and Cold Beverage',
                   textAlign: TextAlign.start,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                //  GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Tea and Coffee', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Juice', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),]),
                  const SizedBox(height: 20),

                Text(
                  'Salad and Raita',
                   textAlign: TextAlign.start,
                  style:TextStyle(
                    color: const Color(0xFFEC1D3C),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  // GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Click 2 Coder', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Click 2', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),
                  const SizedBox(height: 20),
                Text(
                  'Sweets',
                   textAlign: TextAlign.start,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                //  GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Click 2 Coder', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Click 2', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),
                     const SizedBox(height: 20),
                Text(
                  'MOMO,CHOWMMEIN,SOUP,MANCHURIM',
                   textAlign: TextAlign.start,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  // GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Click 2 Coder', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Click 2', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),
                   const SizedBox(height: 20),
                Text(
                  'Rolls',
                   textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  // GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Click 2 Coder', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Click 2', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),
                  const SizedBox(height: 20),
                Text(
                  'Pasta',
                   textAlign: TextAlign.start,
                  style:TextStyle (
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                //  GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Click 2 Coder', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Click 2', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),
                 const SizedBox(height: 20),
                Text(
                  'Pizza and Platter',
                   textAlign: TextAlign.start,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  // GoogleFonts.lato
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      myPro(context,'assets/images/dosa.jpg', 'Click 2 Coder', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Click 2', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'Click 4', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'It is complicated ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
        ),
          bottomNavigationBar: Container(
          height: 45,
          decoration: const BoxDecoration(
            color: Color(0xFFFAF5E1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  
                   Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                               recipeMenu: [], title: '', 
                            ),
                          ));
                   
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                  size:26,
                ),
              ),
             
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.widgets_outlined,
                  color: Colors.black,
                  size:26,
                ),
              ),
               IconButton(
                enableFeedback: false,
                onPressed: () {
                   Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(
                              context: context, 
                            ),
                          ));
                },
                icon: const Icon(
                 Icons.shopping_cart,
                   color: Colors.black,
                  size:26,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(
                        email: '',
                        phoneNumber: '',
                        username: '',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.black,
                size:26,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
