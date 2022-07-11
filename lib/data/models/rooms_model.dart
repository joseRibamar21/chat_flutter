import '../../domain/entities/entities.dart';
import 'models.dart';

class RoomsModel {
  final List<RoomEntity> listRoom;
  RoomsModel({required this.listRoom});

  factory RoomsModel.fromJson(dynamic json) {
    return RoomsModel(
        listRoom: json['listRoom']
            .map<RoomEntity>((e) => RoomModel.fromJson(e).toEntity())
            .toList());
  }

  factory RoomsModel.fromEntity(RoomsEntity entity) =>
      RoomsModel(listRoom: entity.listRoom);

  Map<String, dynamic> toJson() => {
        "listRoom": listRoom
            .map<Map<String, dynamic>>((e) => RoomModel.fromEntity(e).toJson())
            .toList(),
      };

  RoomsEntity toEntity() => RoomsEntity(listRoom: listRoom);
}
