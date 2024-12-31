import 'package:spotify_flutter_apk/domain/entities/auth/user.dart';

class UserModel {

  String? fullName;
  String? userName;
  String? imageUrl;

  UserModel({
    this.fullName,
    this.userName,
    this.imageUrl,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    userName = data['username'];
  }
}

extension UserModelExt on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      userName: userName,
    );
  }
}
