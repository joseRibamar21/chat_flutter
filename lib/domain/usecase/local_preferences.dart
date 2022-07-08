import '../entities/entities.dart';
import 'usecase.dart';

abstract class LocalPreferences {
  LocalStoragePreferences local;
  LocalPreferences({required this.local});

  ///Atualiza o valor do nome fantasia
  Future<bool> setName({required String name});

  ///Atualiza o valor do time
  Future<bool> setTime({required int time});

  ///Salvar local
  Future<PreferencesEntity> getData();

  ///Limpar dados
  Future<bool> reset();
}
