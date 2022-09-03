import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(getUid()); // get uid from firebase
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

String getUid() {
  try {
    var userid = "";
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userid = (currentUser.uid).toString();
    } // get uid from firebase
    return userid;
  } catch (e) {
    print(e);
    return "";
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}