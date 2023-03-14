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
      print(data);
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
    DateTime time = DateTime.now();
    try {
      String data = jsonEncode({
        "code": "",
        "nick": "",
        "timer": 3600000,
        "theme": 1,
        "password": "",
        "hash": time.millisecondsSinceEpoch.toString(),
        "isDeveloper": false,
        "expirationCode": ""
      });

      await storage.save(data);
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

  @override
  Future<bool> setPassword({required String password}) async {
    try {
      var data = jsonDecode(await storage.read());
      data!['password'] = password;
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
  Future<bool> verifyPassword({required String password}) async {
    try {
      var data = jsonDecode(await storage.read());
      if (data!['password'] == password) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  @override
  Future<bool> setCode(
      {required String code, required String expiration}) async {
    try {
      var data = jsonDecode(await storage.read());
      if (code == "dev123") {
        data!['isDeveloper'] = true;
      }
      data!['code'] = code;
      data!['expirationCode'] = expiration;
      await storage.save(jsonEncode(data));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyIsDeveloper() async {
    try {
      var data = jsonDecode(await storage.read());
      if (data!['isDeveloper'] != null) {
        return data['isDeveloper'];
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
