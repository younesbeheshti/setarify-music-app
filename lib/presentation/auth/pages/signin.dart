import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_flutter_apk/common/widgets/appbar/app_bar.dart';
import 'package:spotify_flutter_apk/common/widgets/button/basic_app_button.dart';
import 'package:spotify_flutter_apk/core/configs/assets/app_vectors.dart';
import 'package:spotify_flutter_apk/data/models/auth/signin_user_req.dart';
import 'package:spotify_flutter_apk/presentation/auth/pages/signup.dart';

import '../../../domain/usecases/auth/sign_in.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});


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
      body: SingleChildScrollView(
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

                // TODO: just for testing, it has to be removed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );


                var result = await sl<SignInUseCase>().call(
                  params: SignInUserReq(
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
                      builder: (context) => HomePage(),
                    ),
                  );
                });
              },
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

  Widget _userNameField(BuildContext context) {
    return TextField(
      controller: _userNameController,
      decoration: InputDecoration(
        hintText: "Enter Username",
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
