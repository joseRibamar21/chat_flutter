import '../entities/entities.dart';

abstract class LocalPreferences {
  ///Atualiza o valor do nome fantasia
  Future<bool> setName({required String name});

  ///Atualiza o valor do time
  Future<bool> setTime({required int time});

  ///Atualiza o valor do tema
  Future<bool> setTheme({required int theme});

  ///Salvar local
  Future<PreferencesEntity> getData();

  ///Limpar dados
  Future<bool> reset();
}
