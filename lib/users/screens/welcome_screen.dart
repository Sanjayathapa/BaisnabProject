
import 'package:flutter/material.dart';

import '../craud/signup_screen.dart';

import '../craud/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF6BFFE6),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
         decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/back.jpg",
         ),fit: BoxFit.cover,),
          
          ),
         
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
    const SizedBox(height: 90,),
             const SizedBox(
              height: 180,
              width: 450,
               child: Opacity(
              opacity: 0.8,
               child:Image(
                  image: AssetImage("assets/images/bai.png"), 
                  
                  ),
            ),),
            const SizedBox(height:100),
              
             Padding(
                padding: const EdgeInsets.all(10.0), 
                child:Opacity(
            opacity: 0.8,
              child:Container(
      height: 50.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
         
          colors: [Color(0xFF0B0C0C), Color(0xFF0B0C0C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
           child: Opacity(
            opacity: 0.5,
           child:ElevatedButton(
            
            style: ElevatedButton.styleFrom(
               backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Set border radius
                    ),
                  ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
                 child: Text(
                    "Login", 
                      style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 20,),
                    ),
            ),))),),
             Padding(
                padding: const EdgeInsets.all(10.0),
                child: Opacity(
            opacity: 0.8,
              child:Container(
      height: 50.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        
        gradient: LinearGradient(
          colors: [Color(0xFF0B0C0C), Color(0xFF0B0C0C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
       child: Opacity(
            opacity: 0.5,
            child:ElevatedButton(
             
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Set border radius
        ),
      ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
               child: Text(
       "Register", 
        style: TextStyle(color: Colors.white, fontSize: 20,),
      ),
    ),
            ),
            ))),
            const SizedBox(height: 20),
         
          ],
        ),
      ),
    );
  }
}
