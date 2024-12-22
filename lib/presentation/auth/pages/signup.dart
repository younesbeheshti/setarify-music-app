import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_flutter_apk/common/widgets/appbar/app_bar.dart';
import 'package:spotify_flutter_apk/common/widgets/button/basic_app_button.dart';
import 'package:spotify_flutter_apk/core/configs/assets/app_vectors.dart';
import 'package:spotify_flutter_apk/presentation/auth/pages/signin.dart';
import 'package:spotify_flutter_apk/presentation/root/pages/root.dart';

import '../../../data/models/auth/create_user_req.dart';
import '../../../domain/usecases/auth/sign_up.dart';
import '../../../service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});


  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        child: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerText(),
                SizedBox(
                  height: 50,
                ),
                _fullNameField(context),
                SizedBox(
                  height: 15,
                ),
                _userNameField(context),
                SizedBox(
                  height: 15,
                ),
                _passwordField(context),
                SizedBox(
                  height: 15,
                ),
                BasicAppButton(
                  onPressed: () async {
                    var result = await sl<SignUpUseCase>().call(
                      CreateUserReq(
                        fullName: _fullNameController.text.toString(),
                        userName: _userNameController.text.toString(),
                        password: _passwordController.text.toString(),
                      ),
                    );

                    result.fold((l) {
                      var snackBar = SnackBar(
                        content: Text(l),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }, (r) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RootPage(),
                        ),
                      );
                    });
                  },
                  title: 'Create Account',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _signInText(context),
    );
  }

  Widget _registerText() {
    return Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullNameController,
      decoration: InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _userNameField(BuildContext context) {
    return TextField(
      controller: _userNameController,
      decoration: InputDecoration(
        hintText: "username",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Do you have an account? ",
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
                  builder: (BuildContext builder) => SignInPage(),
                ),
              );
            },
            child: Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
