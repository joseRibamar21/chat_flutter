import '../../domain/entities/entities.dart';

class UserModel {
  final String name;
  final String hash;

  UserModel({required this.name, required this.hash});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name'], hash: json['hash']);
  }

  factory UserModel.fromEntity(UserEntity entity) =>
      UserModel(name: entity.name, hash: entity.hash);

  Map<String, dynamic> toJson() => {"name": name, "hash": hash};

  UserEntity toEntity() => UserEntity(name: name, hash: hash);
}
