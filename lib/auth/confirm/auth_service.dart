 
 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:firebase_core/firebase_core.dart';
 import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
 final _auth=FirebaseAuth.instance;
//  Future signInWithEmailAndPassword(String email, String password) async {
//     try {
//      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       var user = result.user;
//       return user;
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }
 }