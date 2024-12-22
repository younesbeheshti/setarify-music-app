import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/repository/auth.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/signin_user_req.dart';
import '../../../service_locator.dart';

class SignInUseCase extends UseCase<Either, SignInUserReq> {
  @override
  Future<Either> call(SignInUserReq params) async {
    // TODO: implement call
    return sl<AuthRepository>().signIn(params);
  }

}