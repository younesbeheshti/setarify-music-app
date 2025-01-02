import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:spotify_flutter_apk/core/configs/assets/app_images.dart';
import 'package:spotify_flutter_apk/core/configs/constants/app_urls.dart';
import 'package:spotify_flutter_apk/data/models/auth/create_user_req.dart';
import 'package:spotify_flutter_apk/data/models/auth/signin_user_req.dart';
import 'package:spotify_flutter_apk/data/models/auth/user.dart';
import 'package:spotify_flutter_apk/data/models/song/song_model.dart';
import 'package:spotify_flutter_apk/data/sources/storage/secure_storage_service.dart';
import 'package:spotify_flutter_apk/domain/entities/auth/user.dart';
import 'package:spotify_flutter_apk/presentation/auth/pages/signup_or_signin.dart';

import '../../../domain/entities/song/song_entity.dart';
import '../../../service_locator.dart';

abstract class AuthBackendService {
  Future<Either> signIn(SignInUserReq signInUserReq);

  Future<Either> signUp(CreateUserReq createUserReq);

  Future<Either> getUser();

  Future<void> logoutUser();

  Future<bool> handleTokenExpiry();

}

class AuthBackendServiceImpl implements AuthBackendService {
  final storage = sl<SecureStorageService>();

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      print("signInUserReq: ${signInUserReq.userName}");
      final url = Uri.parse('https://spectacular.ir/api/token/');

      final response = await http.post(
        // Uri.parse("https://spectacular.ir/api/token/"),
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'X-CSRFToken': csrfToken
        },
        body: jsonEncode(
          {
            "username": signInUserReq.userName,
            "password": signInUserReq.password
          },
        ),
      );

      //TODO : fetch the user date (like name, username and musics ...)
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access'];
        final refreshToken = data['refresh'];
        final username = signInUserReq.userName;
        final password = signInUserReq.password;

        // Store tokens securely
        await storage.write(key: 'access_token', value: accessToken);
        await storage.write(key: 'refresh_token', value: refreshToken);
        await storage.write(key: 'username', value: username);
        await storage.write(key: 'password', value: password);

        print('Login successful!');
        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');
      } else {
        print('Failed to log in: ${response.reasonPhrase}');
        print('Response body: ${response.body}');
      }

      return const Right("SignIn was Success");
    } catch (e) {
      print(e);
      print(e.toString());
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

  @override
  Future<Either> getUser() async {
    try {
      final token = await storage.read(key: 'access_token');
      if (token == null) {
        throw Exception('no jwt token found , please login again');
      }

      final response = await http.get(
        Uri.parse(AppUrls.baseURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add the JWT token here
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final username = await sl<SecureStorageService>().read(key: "username");
        final name = await sl<SecureStorageService>().read(key: "username");
        UserModel userModel = UserModel.fromJson(json.decode(response.body));
        userModel.imageUrl =
            userModel.imageUrl ?? AppImages.userImage;
        userModel.userName = username;
        userModel.fullName = name;

        UserEntity userEntity = userModel.toEntity();

        return Right(userEntity);
      } else {
        throw Exception("failed to fetch user data: ${response.body}");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }


  //TODO :

  Future<Map<String, String>> getAuthHeaders() async {
    final token = await storage.read(key: 'access_token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<void> decodeToken() async {
    final token = await storage.read(key: 'access_token');
    if (token != null) {
      Map<String, dynamic> decoded = JwtDecoder.decode(token);
      print('Decoded Token: $decoded');
    }
  }

  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  @override
  Future<bool> handleTokenExpiry() async {

    final token = await storage.read(key: 'access_token');
    final refToken = await storage.read(key: "refresh_token");

    if(isTokenExpired(refToken!)){

      final username = await storage.read(key: "username");
      final password = await storage.read(key: "password");

      SignInUserReq signInUserReq = SignInUserReq(userName: username!, password: password!);

      await storage.deleteAll();

      await signIn(signInUserReq);
      return true;
    }

    else if (token != null && isTokenExpired(token)) {
      await refreshToken();
      return true;
    }
    return false;
  }

  Future<void> refreshToken() async {
    final url = Uri.parse('https://spectacular.ir/api/token/refresh/');
    final headers = await getAuthHeaders();

    final refreshToken = await storage.read(key: 'refresh_token');

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {'refresh': refreshToken},
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newToken = data['accept'];
      await storage.delete(key: 'access_token');
      await storage.write(key: 'access_token', value: newToken);
    } else {
      throw Exception('Failed to refresh token: ${response.body}');
    }
  }

  @override
  Future<void> logoutUser() async {
    await storage.deleteAll();
  }

}
