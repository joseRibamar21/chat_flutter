import '../entities/entities.dart';

abstract class LocalPreferences {
  ///Atualiza o valor do nome fantasia
  Future<bool> setName({required String name});

  ///Atualiza o valor do time
  Future<bool> setTime({required int time});

  ///Atualiza o valor do tema
  Future<bool> setTheme({required int theme});

  ///Atualiza o valor do tema
  Future<bool> setPassword({required String password});

  ///Atualiza o valor de Code
  Future<bool> setCode({required String code, required String expiration});

  ///Pegar local
  Future<PreferencesEntity> getData();

  ///Limpar dados
  Future<bool> reset();

  ///Verifica se a conta atual é de desenvolvimento
  Future<bool> verifyIsDeveloper();

  Future<bool> verifyPassword({required String password});
}
