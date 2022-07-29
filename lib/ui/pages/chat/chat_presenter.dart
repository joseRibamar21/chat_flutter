import '../../../domain/entities/entities.dart';

abstract class ChatPresenter {
  Stream<List<MessageEntity>> get listMessagesStream;
  Stream<List<Map<String, dynamic>>> get listSendersStream;
  Stream<String?> get roomNameString;
  Stream<String?> get desconectStream;

  void inicialization();

  /// Funcão para mandar uma mensagem.
  ///
  /// Parâmetros: [value] será a mensagem a ser enviada.
  void send(String? value);

  /// Função para apagar uma mensagem para todos
  void sendRemoveMessage({required String id});

  /// Funcão que emite um sinal de retorno de visibilidade.
  void resume();

  /// Funcão que emite um sinal de visibilidade inativa.
  void inactive();

  void disp();

  String? get link;
}
