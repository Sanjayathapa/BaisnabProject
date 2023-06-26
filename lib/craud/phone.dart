import 'dart:developer';
// import 'package:google_fonts/google_fonts.dart';

import 'verifyotp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SignWithPhone extends StatefulWidget {
  const SignWithPhone({Key? key}) : super(key: key);

  @override
  State<SignWithPhone> createState() => _SignWithPhoneState();
}

class _SignWithPhoneState extends State<SignWithPhone> {
  TextEditingController Phonecontroller = TextEditingController();

  void sendOTP() async {
    String phone = "+977${Phonecontroller.text.trim()}";
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(context, MaterialPageRoute(builder:(context)=> Verify(verificationId: verificationId)));
          
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          log(ex.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white10,
     
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Center(
                child: Column(
                  
                  children: [
               ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Sign In With Phone',
                          style:TextStyle (
                    //  GoogleFonts.lato      
                            fontSize: 45,
                          ),
                        ),
                      ),
                    ),
                  ])
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Phone',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: Phonecontroller,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                      fillColor: Colors.white10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff14dae2), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                  fixedSize: const Size(180, 50),
                  backgroundColor: Colors.greenAccent, // Set the background color
                  foregroundColor: Colors.blueAccent, // Set the text color
                    ),
                   
                      onPressed: () {
                        sendOTP();
                      },
                      child: Text('Verify', 
                      style:TextStyle (
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),)))
            ]),
      ),
    );
  }
}
// GoogleFonts.lato