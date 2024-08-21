import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallpaper_gallery/utils/authentication_utils.dart';

class AuthenticationAnonymousOption extends OptionModal {}

class AuthenticationAnonymous
    extends Authentication<AuthenticationAnonymousOption> {
  @override
  Future<UserCredential> onSignInAuthentication(
      AuthenticationAnonymousOption options) async {
    try {
      return await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential?> onSignUpAuthentication(
      AuthenticationAnonymousOption options) async {
    return null;
  }
}
