import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_flutter_apk/data/models/auth/create_user_req.dart';

abstract class AuthBackendService {
  Future<void> signIn();

  Future<Either> signUp(CreateUserReq createUserReq);
}

class AuthBackendServiceImpl implements AuthBackendService {
  @override
  Future<void> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    Map user = {
      "name": createUserReq.fullName,
      "userName": createUserReq.userName,
      "password": createUserReq.password
    };

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

      return const Right("SignUp was Success");
    } catch (e) {
      print(e);

      return Left(e.toString());
    }
  }
}
