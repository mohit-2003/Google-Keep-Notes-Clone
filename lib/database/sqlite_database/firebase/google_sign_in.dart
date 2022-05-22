import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final _googleSignIn = new GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  GoogleSignInAccount? get currentUser => _currentUser;

  Future logInWithGoogle() async {
    try {
      // if (currentUser != null) {
      //   await _googleSignIn.disconnect();
      //   await FirebaseAuth.instance.signOut();
      // }
      final user = await _googleSignIn.signIn();
      if (user == null) return;
      _currentUser = user;

      final GoogleSignInAuthentication auth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: auth.idToken, accessToken: auth.accessToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
