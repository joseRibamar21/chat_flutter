import 'dart:convert';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecase/usecase.dart';
import '../../models/models.dart';

class GetPreferencesStorage implements LocalPreferences {
  final LocalStorage storage;

  GetPreferencesStorage({required this.storage});

  @override
  Future<PreferencesEntity> getData() async {
    try {
      var data = jsonDecode(await storage.read());
      return PreferencesModel.fromJson(data).toEntity();
    } catch (e) {
      if (await reset()) {
        var data = jsonDecode(await storage.read());
        return PreferencesModel.fromJson(data).toEntity();
      } else {
        throw "Error ao receber dados preferencias";
      }
    }
  }

  @override
  Future<bool> reset() async {
    try {
      await storage.save(jsonEncode({"nick": "", "timer": 60, "theme": 1}));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setName({required String name}) async {
    try {
      var data = jsonDecode(await storage.read());
      data!['nick'] = name;
      await storage.save(jsonEncode(data));
      return true;
    } catch (e) {
      if (await reset()) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Future<bool> setTime({required int time}) async {
    try {
      var data = jsonDecode(await storage.read());
      data!['timer'] = time;
      await storage.save(jsonEncode(data));
      return true;
    } catch (e) {
      if (await reset()) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Future<bool> setTheme({required int theme}) async {
    try {
      var data = jsonDecode(await storage.read());
      data!['theme'] = theme;
      await storage.save(jsonEncode(data));
      return true;
    } catch (e) {
      if (await reset()) {
        return true;
      } else {
        return false;
      }
    }
  }
}
