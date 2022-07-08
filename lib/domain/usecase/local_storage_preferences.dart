abstract class LocalStoragePreferences {
  ///Salvar local
  Future<bool> saveData(Map<String, dynamic> json);

  ///Salvar local
  Future<Map<String, dynamic>?> getData();

  ///Limpar dados
  Future<bool> delete();
}
