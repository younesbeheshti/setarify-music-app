import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/domain/repository/auth/auth.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/signin_user_req.dart';
import '../../../service_locator.dart';

class HandleTokenExpiryUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async{
    return await sl<AuthRepository>().handleTokenExpiry();
  }




}