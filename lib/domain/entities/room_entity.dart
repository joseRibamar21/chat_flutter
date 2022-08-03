class RoomEntity {
  final String master;
  final String name;
  final String password;
  String? expirateAt;
  RoomEntity(
      {required this.master,
      required this.name,
      required this.password,
      required this.expirateAt});
}
