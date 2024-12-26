import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  Future<Either> getNewsSongs();
  //this is not play list (it is actually all music in the db)(there is not logic for play list for your own)
  Future<Either> getPlayList();
}