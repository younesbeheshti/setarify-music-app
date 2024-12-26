import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/repository/auth/auth.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/create_user_req.dart';
import '../../../service_locator.dart';

class SignUpUseCase extends UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    // TODO: implement call
    return sl<AuthRepository>().signUp(params!);
  }

}