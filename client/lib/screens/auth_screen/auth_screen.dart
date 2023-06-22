import 'package:flutter/material.dart';
import 'package:whisper/widgets/app_decorations/app_decoration.dart';
import 'widgets/google_sign_in_button.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = "/authScreen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                WhisperIcon(),
                SizedBox(height: 60),
                WhisperText(),
              ],
            ),
            Center(child: GoogleSignInButton()),
          ],
        ),
      ),
    );
  }
}