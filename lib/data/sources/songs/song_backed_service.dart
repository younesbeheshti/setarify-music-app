import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:spotify_flutter_apk/data/sources/storage/secure_storage_service.dart';

import 'package:http/http.dart' as http;
import '../../../core/configs/constants/app_urls.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../../service_locator.dart';
import '../../models/song/song_model.dart';

abstract class SongService {
  Future<Either> getNewsSongs();

  Future<Either> getPlayList();

  Future<Either> addOrRemoveFavoriteSongs(SongEntity songEntity);

  Future<bool> isFavoriteSong(String songId);

  Future<Either> getUserFavoriteSongs();

  Future<String> getSongUrl(String song_slug);
}

class SongServiceImpl implements SongService {
  final storage = sl<SecureStorageService>();

  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songList = [];

      final token = await storage.read(key: 'access_token');
      final username = await storage.read(key: 'username');
      final url = Uri.parse(AppUrls.baseURL + AppUrls.songsUrl);
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      for (var element in json.decode(respond.body)) {
        var songModel = SongModel.fromJson(element);

        songModel.slug = element['slug'];

        print("element -> $element \n");

        songList.add(songModel.toEntity());
      }

      return Right(songList);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songList = [];

      final token = await storage.read(key: 'access_token');
      final url = Uri.parse(AppUrls.baseURL + AppUrls.songsUrl);
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(json.decode(respond.body));

      for (var element in json.decode(respond.body)) {
        var songModel = SongModel.fromJson(element);

        print("element -> $element \n");

        songList.add(songModel.toEntity());
      }

      return Right(songList);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(SongEntity songEntity) async {

    try {
      if(songEntity.liked!)
        final response = await call("${AppUrls.baseURL}${AppUrls.songsUrl}${songEntity.slug}/dislike/", http.get);
      else
        final response = await call("${AppUrls.baseURL}${AppUrls.songsUrl}${songEntity.slug}/like/", http.get);

      // print(response);
      bool liked = !songEntity.liked!;
      songEntity.liked = liked;
      return Right(liked);
    } catch (e) {
      return Left(e);
    }
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

      final url = Uri.parse(
          AppUrls.baseURL + AppUrls.songsUrl + song_slug + "/get_url/");
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (respond.statusCode == 200) {
        print(respond.body);

        return json.decode(respond.body)['file_url'];
      }
    } catch (e) {
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

      final url =
          Uri.parse(AppUrls.baseURL + AppUrls.songsUrl + '?user=' + username);
      final respond = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      List<SongEntity> userSongList = [];

      if (respond.statusCode == 200) {
        print(respond.body);

        for (var element in json.decode(respond.body)) {
          // final slug = element['slug'];
          // final urlSong = await Uri.parse(
          //     AppUrls.baseURL + AppUrls.songsUrl + slug + AppUrls.getUrl);
          // final responseSongUrl = http.get(urlSong, headers: {
          //   'Content-Type': 'application/json',
          //   'Authorization': 'Bearer $token',
          // });
          print("element -> $element");
          SongModel songModel = SongModel.fromJson(element);
          userSongList.add(songModel.toEntity());
        }
      }
      return Right(userSongList);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Map<String, dynamic>> call(
    String uri,
    Function f, {
    JsonCodec? data,
  }) async {
    final username = await storage.read(key: 'username');
    final token = await storage.read(key: 'access_token');

    final url = Uri.parse(uri.replaceAll("{username}", "$username"));
    var response;
    if (data == null) {
      response = await f(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    }else {
      response = await f(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body:jsonEncode(data),
      );
    }
    try {
      return jsonDecode(response.body);
    }catch (e){
      return jsonDecode("{}");
    }
  }


}
