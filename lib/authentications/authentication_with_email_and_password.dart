import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallpaper_gallery/utils/authentication_utils.dart';

class AuthenticationWithEmailAndPasswordOption extends OptionModal {
  final String password;
  final String email;

  AuthenticationWithEmailAndPasswordOption(
      {required this.password, required this.email});
}

class AuthenticationWithEmailAndPassword
    extends Authentication<AuthenticationWithEmailAndPasswordOption> {
  @override
  Future<UserCredential> onSignInAuthentication(
      AuthenticationWithEmailAndPasswordOption options) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: options.email, password: options.password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> onSignUpAuthentication(
      AuthenticationWithEmailAndPasswordOption options) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: options.email, password: options.password);
    } catch (e) {
      rethrow;
    }
  }
}
