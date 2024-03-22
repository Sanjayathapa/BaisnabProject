import 'package:baisnab/users/craud/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

// class FirebaseAuthService {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   Future login(String email, String password) async {
//     await auth.signInWithEmailAndPassword(email: email, password: password);
//   }

//   Future signup(String email, String password) async {
//     await auth.createUserWithEmailAndPassword(email: email, password: password);
//   }

//   Future logininwithgoogle() async {
//     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//     AuthCredential myCredential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     UserCredential user =
//         await FirebaseAuth.instance.signInWithCredential(myCredential);

//     debugPrint(user.user?.displayName);
//   }
// }

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint("Error during login: $e");
      throw e; // Re-throw the exception to handle it in the calling widget
    }
  }

  Future<void> signup(String email, String username, String password, String address, String phoneNumber) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      // After signing up, you can store additional user details in Firestore
      await postDetailsToFirestore(email, username, address, phoneNumber, auth);
    } catch (e) {
      debugPrint("Error during signup: $e");
      throw e; 
    }
  }


  Future<void> loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential myCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential user = await FirebaseAuth.instance.signInWithCredential(myCredential);
      debugPrint(user.user?.displayName);
    } catch (e) {
      debugPrint("Error during Google Sign-In: $e");
    }
  }
}
