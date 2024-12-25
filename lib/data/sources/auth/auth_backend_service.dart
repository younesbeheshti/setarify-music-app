import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_flutter_apk/data/models/auth/create_user_req.dart';
import 'package:spotify_flutter_apk/data/models/auth/signin_user_req.dart';

abstract class AuthBackendService {
  Future<Either> signIn(SignInUserReq signInUserReq);

  Future<Either> signUp(CreateUserReq createUserReq);
}

class AuthBackendServiceImpl implements AuthBackendService {
  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8080/auth"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "userName": signInUserReq.userName,
            "password": signInUserReq.password
          },
        ),
      );

      print(response.body);

      //TODO : fetch the user date (like name, username and musics ...)

      return const Right("SignIn was Success");
    } catch (e) {
      print(e);

      return Left(e.toString());
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8080/user"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": createUserReq.fullName,
            "userName": createUserReq.userName,
            "password": createUserReq.password
          },
        ),
      );

      print(response.body);

      // TODO: make a instance of collection of users in db
      // actually it is not necessary, it handled by backend
      // FirebaseFirstore.instance.collection("users").add(
      //   {
      //     "name": createUserReq.fullName,
      //     "userName": createUserReq.userName,
      //   },
      //   },);

      return const Right("SignUp was Success");
    } catch (e) {

      String message = "";

      // if (e.message == 'userName-already-in-use')
      //   {
      //     message = "userName already in use";
      //   }

      print(e);

      return Left(e.toString());
    }
  }
}
