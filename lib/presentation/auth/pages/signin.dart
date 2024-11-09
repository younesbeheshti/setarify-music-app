import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_flutter_apk/common/widgets/appbar/app_bar.dart';
import 'package:spotify_flutter_apk/common/widgets/button/basic_app_button.dart';
import 'package:spotify_flutter_apk/core/configs/assets/app_vectors.dart';
import 'package:spotify_flutter_apk/presentation/auth/pages/signup.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            SizedBox(
              height: 50,
            ),
            _emailOrUserNameField(context),
            SizedBox(
              height: 15,
            ),
            _passwordField(context),
            SizedBox(
              height: 15,
            ),
            BasicAppButton(
              onPressed: () {},
              title: 'Create Account',
            ),
          ],
        ),
      ),
      bottomNavigationBar: _signUpText(context),
    );
  }

  Widget _registerText() {
    return Text(
      "Sign In",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailOrUserNameField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Enter Username or Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signUpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Not A Member? ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext builder) => SignupPage(),
                ),
              );
            },
            child: Text("Register Now"),
          ),
        ],
      ),
    );
  }
}
