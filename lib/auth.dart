import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  void register(String? emailAddress, String? password) async {
    if (emailAddress == null || password == null) {
      print("Vazio");
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress as String,
          password: password as String,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> login(String? emailAddress, String? password) async {
    if (emailAddress == null || password == null) {
      print("Vazio");
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return false;
        } else if (e.code == 'wrong-password') {
          return false;
        }
        return false;
      }
    }
    return true;
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
