import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/authentications/authentication_anonymous.dart';
import 'package:wallpaper_gallery/authentications/authentication_with_email_and_password.dart';
import 'package:wallpaper_gallery/enums/authentication.dart';
import 'package:wallpaper_gallery/screen/splash_screen.dart';
import 'package:wallpaper_gallery/utils/authentication_utils.dart';

import '../widgets/custom_text_form_field.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _authenticationFormKey = GlobalKey<FormState>();
  String _enteredEmail = "";
  String _enteredPassword = "";

  bool isAuthenticating = false;
  bool isLogin = true;
  void toggleAuthenticationType() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _submit(
      AuthenticationType authenticationType, bool checkValidation) async {
    if (checkValidation && !_authenticationFormKey.currentState!.validate()) {
      return;
    }

    _authenticationFormKey.currentState!.save();
    setState(() {
      isAuthenticating = true;
    });

    Authentication authentication;
    switch (authenticationType) {
      case AuthenticationType.emailAndPassword:
        authentication = AuthenticationWithEmailAndPassword();
      case AuthenticationType.anonymously:
        authentication = AuthenticationAnonymous();
    }

    try {
      if (isLogin) {
        switch (authenticationType) {
          case AuthenticationType.emailAndPassword:
            await authentication.onSignInAuthentication(
                AuthenticationWithEmailAndPasswordOption(
                    password: _enteredPassword, email: _enteredEmail));
          case AuthenticationType.anonymously:
            await authentication
                .onSignInAuthentication(AuthenticationAnonymousOption());
        }

        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Successful"),
            ),
          );
        }
      } else {
        switch (authenticationType) {
          case AuthenticationType.emailAndPassword:
            await authentication.onSignUpAuthentication(
                AuthenticationWithEmailAndPasswordOption(
                    password: _enteredPassword, email: _enteredEmail));
          case AuthenticationType.anonymously:
            await authentication
                .onSignUpAuthentication(AuthenticationAnonymousOption());
        }

        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Signed Successful"),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Authentication Failed"),
          ),
        );
      }
    }

    setState(() {
      isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticating
        ? const SplashScreen()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    "assets/icon/logo_2.png",
                    height: 200,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Log in to WallFeast",
                    style: GoogleFonts.josefinSans().copyWith(fontSize: 24),
                  ),
                  const Text("· · ─────── ·𖥸· ─────── · ·"),
                  Form(
                    key: _authenticationFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          mainText: "Email or username",
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty ||
                                !value.contains("@")) {
                              return "Please enter correct email";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          mainText: "Password",
                          obscureText: true,
                          onChanged: (value) => _enteredPassword = value!,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty ||
                                value.trim().length < 5) {
                              return "Please enter password with minimum length of 6 ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                        if (!isLogin)
                          CustomTextFormField(
                            mainText: "Confirm Password",
                            obscureText: true,
                            validator: (value) {
                              if (_enteredPassword != value) {
                                return "Password not matched";
                              }

                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 5, top: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _submit(
                                  AuthenticationType.emailAndPassword, true),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary),
                              child: Text(
                                isLogin ? "Log in" : "Sign up",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            ),
                          ),
                        ),
                        const Text("· · ─────── ·▲· ─────── · ·"),
                        TextButton(
                          onPressed: toggleAuthenticationType,
                          child: Text(
                            isLogin
                                ? "Don't have an account?"
                                : "Already have an account?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface,
                                ),
                          ),
                        ),
                        if (isLogin)
                          TextButton(
                            onPressed: () =>
                                _submit(AuthenticationType.anonymously, false),
                            child: Text(
                              "Use anonymously",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inverseSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
