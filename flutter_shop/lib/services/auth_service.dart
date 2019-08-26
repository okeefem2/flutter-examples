import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn({email, password, register = false}) async {
    FirebaseUser user;
    if (register) {
      user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } else {
      final AuthCredential credential = EmailAuthProvider.getCredential(
        email: email,
        password: password,
      );
      user = (await _auth.signInWithCredential(credential)).user;
    }
    return user;
  }

  void signOut() {
    _auth.signOut();
  }
}
