class RoomEntity {
  final String master;
  final String masterHash;
  final String name;
  final String password;
  final String roomHash;
  String? expirateAt;
  RoomEntity(
      {required this.master,
      required this.masterHash,
      required this.name,
      required this.roomHash,
      required this.password,
      required this.expirateAt});
}
