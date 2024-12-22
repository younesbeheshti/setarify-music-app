import 'package:get_it/get_it.dart';
import 'package:spotify_flutter_apk/data/sources/auth_backend_service.dart';
import 'package:spotify_flutter_apk/domain/repository/auth.dart';
import 'package:spotify_flutter_apk/domain/usecases/auth/sign_up.dart';

import 'data/repository/auth_repository_impl.dart';
import 'domain/usecases/auth/sign_in.dart';

final sl = GetIt.instance;


Future<void> initializeDependencies() async {

  sl.registerSingleton<AuthBackendService>(
    AuthBackendServiceImpl(),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(),
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(),
  );

}