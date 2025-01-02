import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/repository/auth/auth.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/signin_user_req.dart';
import '../../../service_locator.dart';

class LogOutUseCase extends UseCase<void, dynamic> {
  @override
  Future<void> call({params}) async {
    return await sl<AuthRepository>().logoutUser();
  }



}