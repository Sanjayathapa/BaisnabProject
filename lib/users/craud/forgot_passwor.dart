import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({Key? key}) : super(key: key);

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  late String email;
  TextEditingController emailController = TextEditingController();
  bool isEmailValid(String email) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
     
      child: Scaffold(
          backgroundColor: const Color(0xFFE5F9F6),
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                      padding: const EdgeInsets.symmetric(vertical: 190.0, horizontal: 10.0),
                        child: Container(
                          height: 150,
                          width: 50,
                          child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_sharp,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                      Center(
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Forgot Password??",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/images/forgotpassword.jpg",
                                width: 250,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'E-mail',
                                  labelText: ' E-mail',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Email';
                                  } else if (!isEmailValid(value)) {
                                    return 'Please enter a valid Email';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                    height: 50.0,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.purple],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                                  email: email)
                                              .then((value) =>
                                                  Navigator.of(context).pop());
                                        },
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        )))),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'If you need to reset your password, please follow the steps below:\n1. Enter your email address associated with your account.\n2. Check your email for a password reset link. Make sure to check your spam folder if you dont see it in your inbox.\n3. Click on the password reset link and follow the instructions to create a new password.\n4. Once you have created a new password, you should be able to log in to your account with your new password.',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xFF01277A),
                                    height: 1.5),
                                // GoogleFonts.lato
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ]),
                    ]),
              ),
            ),
          )),
    ));
  }
}
