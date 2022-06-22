class BodyEntity {
  final String message;
  final int connecting;
  BodyEntity({required this.message, required this.connecting});
}

/* 
0 - Descontectado
1 - Conectado
2 - Conectado para lista
3 - Nova conexão 
4 - Inativo
*/