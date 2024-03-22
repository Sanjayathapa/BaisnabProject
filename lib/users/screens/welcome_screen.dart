
import 'package:flutter/material.dart';

import '../craud/signup_screen.dart';
import '../../widgets/customized_button.dart';
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
           child: CustomizedButton(
              buttonText: "Login",
             
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
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
            child:CustomizedButton(
              buttonText: "Register", 
             
              textColor: const Color.fromARGB(255, 252, 252, 252),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            ),)))),
            const SizedBox(height: 20),
         
          ],
        ),
      ),
    );
  }
}
