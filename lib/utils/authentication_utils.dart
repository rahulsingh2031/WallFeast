import 'package:firebase_auth/firebase_auth.dart';

abstract class Authentication<T extends OptionModal> {
  Future<UserCredential> onSignInAuthentication(T options);
  Future<UserCredential?> onSignUpAuthentication(T options);
}

abstract class OptionModal {}
