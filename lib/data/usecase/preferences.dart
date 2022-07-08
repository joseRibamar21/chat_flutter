import 'dart:math';

import '../../domain/entities/entities.dart';
import '../../domain/usecase/usecase.dart';
import '../models/models.dart';

class Preferences implements LocalPreferences {
  @override
  LocalStoragePreferences local;

  Preferences({required this.local});

  @override
  Future<PreferencesEntity> getData() async {
    try {
      var data = await local.getData();
      return PreferencesModel.fromJson(data).toEntity();
    } catch (e) {
      if (await reset()) {
        var data = await local.getData();
        return PreferencesModel.fromJson(data).toEntity();
      } else {
        throw "Error ao receber dados preferencias";
      }
    }
  }

  @override
  Future<bool> reset() async {
    try {
      await local
          .saveData({"user": "usuario ${Random().nextInt(1000)}", "timer": 60});
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setName({required String name}) async {
    try {
      var data = await local.getData();
      data!['user'] = name;
      await local.saveData(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setTime({required int time}) async {
    try {
      var data = await local.getData();
      data!['timer'] = time;
      await local.saveData(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
