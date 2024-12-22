import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/data/models/auth/create_user_req.dart';

abstract class AuthRepository {

  Future<void> signIn();

  Future<Either> signUp(CreateUserReq createUserReq);

}