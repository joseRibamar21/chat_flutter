class BodyEntity {
  final String? id;
  final String? message;
  final int function;
  BodyEntity({required this.id, required this.message, required this.function});
}

/* 
0 - Descontectado
1 - Conectado
2 - Conectado para lista
3 - Nova conexão 
4 - Inativo
*/