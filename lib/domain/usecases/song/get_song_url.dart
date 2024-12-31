import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/music/song_repo.dart';

class getSongUrlUseCase extends UseCase<dynamic, String> {
  @override
  Future<dynamic> call({String? params}) async{
    return await sl<SongsRepository>().getSongUrl(params!);
  }




}