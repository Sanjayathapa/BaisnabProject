import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key

  // Variables to toggle visibility of passwords
  var isOldPasswordObscured = true;
  var isNewPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
       backgroundColor: Color.fromARGB(255, 227, 246, 253),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 40,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
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
                      child: const  Padding(
                       padding: const EdgeInsets.symmetric(
                         horizontal: 20, vertical: 22),
                        child: Text(  "Password change screen",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                  
                  ],
                ),
                SizedBox(height: 70),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_rounded),
                              labelText: 'E-mail',
                              hintText: 'Your E-mail',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an Email';
                              } else if (!isEmailValid(value)) {
                                return 'Please enter a valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        buildPasswordTextField(
                          controller: _oldPasswordController,
                          isObscured: isOldPasswordObscured,
                          labelText: 'Old Password',
                        ),
                        SizedBox(height: 16.0),
                        buildPasswordTextField(
                          controller: _newPasswordController,
                          isObscured: isNewPasswordObscured,
                          labelText: 'New Password',
                        ),
                        SizedBox(height: 32.0),
                         Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50.0,
                    
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                          colors: [Color(0xEB4BDBF8), Color.fromARGB(255, 225, 102, 249)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                  
                       child: ElevatedButton(
                          onPressed: () async {
                            await _changePassword(context);
                          },
                           style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)
                            ),
                          fixedSize: const Size(220, 60),
                       
                          ),
                          
                          child: Text('Change Password', 
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,
                         
                          fontSize: 17),),
                        ),
                          ),
                  ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordTextField({
    required TextEditingController controller,
    required bool isObscured,
    required String labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscured,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_open),
          suffixIcon: IconButton(
            icon: Icon(
              isObscured ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                if (controller == _oldPasswordController) {
                  isOldPasswordObscured = !isOldPasswordObscured;
                } else if (controller == _newPasswordController) {
                  isNewPasswordObscured = !isNewPasswordObscured;
                }
              });
            },
          ),
          hintText: labelText,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Password';
          } else if (value.length < 6) {
            return 'At least enter 6 characters';
          } else if (value.length > 25) {
            return 'Maximum character is 25';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        _showErrorDialog(context, 'User is not signed in.');
        return;
      }

      AuthCredential credential = EmailAuthProvider.credential(
        email: _emailController.text,
        password: _oldPasswordController.text,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(_newPasswordController.text);

      _showSuccessDialog(context, 'Password changed successfully!');

      _emailController.clear();
      _oldPasswordController.clear();
      _newPasswordController.clear();
    } catch (e) {
      _showErrorDialog(context, 'Error: $e');
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]*)?)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$')
        .hasMatch(email);
  }
}
