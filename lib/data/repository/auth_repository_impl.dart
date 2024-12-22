

import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/data/models/auth/create_user_req.dart';
import 'package:spotify_flutter_apk/data/models/auth/signin_user_req.dart';
import 'package:spotify_flutter_apk/data/sources/auth_backend_service.dart';
import 'package:spotify_flutter_apk/domain/repository/auth.dart';
import 'package:spotify_flutter_apk/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    return await sl<AuthBackendService>().signIn(signInUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await sl<AuthBackendService>().signUp(createUserReq);
  }
}