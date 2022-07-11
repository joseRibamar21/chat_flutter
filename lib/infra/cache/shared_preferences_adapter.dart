import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/usecase.dart';

class LocalSharedPreferences implements LocalStoragePreferences {
  final String _name = "preferences";

  ///Salvar local
  @override
  Future<bool> saveData(Map<String, dynamic> json) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_name, "json.toString()");

      return true;
    } catch (e) {
      return false;
    }
  }

  ///Salvar local
  @override
  Future<Map<String, dynamic>?> getData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      var data = prefs.getString(_name);

      return jsonDecode(data ?? "");
    } catch (e) {
      return {};
    }
  }

  ///Limpar dados
  @override
  Future<bool> delete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
