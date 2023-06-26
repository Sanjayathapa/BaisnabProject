
import 'package:baisnab/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../slider/CarouselSlider.dart';
import 'short.dart';

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
           
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Our foods and sweets product',
                      style:TextStyle(
                        color: Colors.white,
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
                      'Food Item',
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
                      myPro(context,'assets/images/laduu.jpg', 'Laduu', '10'),
                      myPro(context,'assets/images/rasburry.jpg', 'Rasburry ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Thali', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'Nang', '5'),
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
                      myPro(context,'assets/images/dosa.jpg', 'momo,chaumin', '60'),
                      myPro(context,'assets/images/jaleby.jpg', 'Pasta and pizza', '20'),
                      myPro(context,'assets/images/laduu.jpg', 'salad and raita', '10'),
                      myPro(context,'assets/images/rasburry.jpg', ' Roti,naan,parautha ', '1'),
                      myPro(context,'assets/images/thali.jpg', 'Data statistics', '10'),
                      myPro(context,'assets/images/nang.jpeg', 'ML', '5'),
                    ],
                  ),
                ),
            ]))),
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
                  //  Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => CartPage(
                  //             context: context, 
                  //           ),
                  //         ));
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
