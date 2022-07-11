class BodyEntity {
  final String? id;
  final String? message;
  final int function;
  final int sendAt;
  BodyEntity(
      {required this.id,
      required this.message,
      required this.function,
      required this.sendAt});
}

/* 
0 - Descontectado
1 - Conectado
2 - Conectado para lista
3 - Nova conexão 
4 - Inativo
*/