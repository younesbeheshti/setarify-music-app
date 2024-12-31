import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:spotify_flutter_apk/data/sources/storage/secure_storage_service.dart';
import 'package:spotify_flutter_apk/domain/entities/song/song_entity.dart';

import 'package:http/http.dart' as http;
import '../../../core/configs/constants/app_urls.dart';
import '../../../domain/usecases/song/is_favorite_song.dart';
import '../../../service_locator.dart';
import '../../models/song/song_model.dart';

abstract class SongService {
  Future<Either> getNewsSongs();

  Future<Either> getPlayList();

  Future<Either> addOrRemoveFavoriteSongs(String songId);

  Future<bool> isFavoriteSong(String songId);

  Future<Either> getUserFavoriteSongs();

  Future<String> getSongUrl(String song_slug);
}

class SongServiceImpl implements SongService {
  final storage = sl<SecureStorageService>();

  @override
  Future<Either> getNewsSongs() async {
    try {
      // TODO: implement getNewsSongs
      List<SongEntity> songList = [];

      final token = await storage.read(key: 'access_token');
      final username = await storage.read(key: 'username');
      final url = Uri.parse(AppUrls.baseURL + AppUrls.songsUrl+ '?user=' + username!);
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (respond.statusCode == 200) {
        // print("in get news song : respond.body: ${respond.body}");
      }

      for (var element in json.decode(respond.body)) {
        var songModel = SongModel.fromJson(element);

        // TODO: implement isFavoriteSong?
        // bool isFavorite = await sl<IsFavoriteSongUseCase>().call(params: element['slug']);
        // songModel.liked = isFavorite;
        songModel.slug = element['slug'];

        songList.add(songModel.toEntity());
      }

      // print("length of list : ${songList.length}");

      return Right(songList);
    } catch (e) {
      // print("failed to load in get news");
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      // TODO: implement getNewsSongs
      List<SongEntity> songList = [];

      final token = await storage.read(key: 'access_token');
      final username = await storage.read(key: 'username');
      final url = Uri.parse(AppUrls.baseURL + AppUrls.songsUrl);
      // url.queryParameters['user'] = username!;
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (respond.statusCode == 200) {
        // print("in get play list respond.body: ${respond.body}");
      }
      for (var element in json.decode(respond.body)) {
        // print(element);
        var songModel = SongModel.fromJson(element);
        // print(element);

      // TODO: implement isFavoriteSong?
      //   bool isFavorite = await sl<IsFavoriteSongUseCase>().call(params: element['slug']);
      //   songModel.liked = isFavorite;
      //   songModel.slug = element['slug'];

        songList.add(songModel.toEntity());
      }
      // print('getPlaylist');
      // print(songList.length);

      return Right(songList);
    } catch (e) {
      // print("failed to load");
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) {
    // TODO: implement addOrRemoveFavoriteSongs
    throw UnimplementedError();
  }

  @override
  Future<bool> isFavoriteSong(String songId) {
    // TODO: implement isFavoriteSong
    throw UnimplementedError();
  }

  @override
  Future<String> getSongUrl(String song_slug) async {
    try {
      final username = await storage.read(key: 'username');
      final token = await storage.read(key: 'access_token');
      if (username == null) {
        throw Exception('no jwt token found , please login again');
      }

      final url = Uri.parse(AppUrls.baseURL + AppUrls.songsUrl + song_slug+"/get_url/");
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (respond.statusCode == 200) {
        print(respond.body);

        return json.decode(respond.body)['file_url'];
      }
    }catch (e){
        print("file url $e");
    }
    return "";
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final username = await storage.read(key: 'username');
      final token = await storage.read(key: 'access_token');
      if (username == null) {
        throw Exception('no jwt token found , please login again');
      }

      final url = Uri.parse(AppUrls.baseURL + AppUrls.songsUrl +'?user=' +username);
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      List<SongEntity> favoriteSongList = [];

      if (respond.statusCode == 200) {
        print(respond.body);

        for (var element in json.decode(respond.body)) {
          if (element['liked']) {
            final slug = element['slug'];
            final urlSong = await Uri.parse(
                AppUrls.baseURL + AppUrls.songUrl + slug + AppUrls.getUrl);
            final responseSongUrl = http.get(urlSong, headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            });

            SongModel songModel = SongModel.fromJson(element);
            // var res = jsonDecode(responseSongUrl.body);
            favoriteSongList.add(songModel.toEntity());
          }
        }
      }
      return Right(favoriteSongList);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
