// ignore_for_file: unused_field

import 'package:get/get.dart';

import '../../../data/usecase/usecase.dart';
import '../../../infra/cache/cache.dart';

class RegisterController extends GetxController {
  final SecureStorage secureStorage = SecureStorage();

  final _rxNavigateTo = Rx<String>("");
  final _rxUiError = Rx<String>("");
  final _rxIsLoading = Rx<bool>(false);
  RoomsStorage _roomsStorage = RoomsStorage();

  String _name = "";
  String _room = "";

  Stream<bool> get isLoading => _rxIsLoading.stream;

  Stream<String> get navigationStream => _rxNavigateTo.stream;

  Stream<String> get uiErrorStream => _rxUiError.stream;

  Future<bool> register() async {
    _rxIsLoading.value = true;
    try {
      await secureStorage.writeSecureData('name', _name);
      // _rxNavigateTo.value = "/home";
      _rxIsLoading.value = false;
      return true;
    } catch (e) {
      _rxUiError.value = "Erro ao carregar dados!";
      _rxIsLoading.value = false;
      return false;
    }
  }

  void validadeName(String value) {
    _name = value;
  }

  void validadeLink(String value) {
    _room = value;
  }

  void enterRoom() {
    if (_room != null && _name != null) {
      var getRoom = _roomsStorage.getRoomFromLink(_name);
      Get.offAndToNamed("/chat/$_name/${getRoom!.name}/${getRoom.password}");
    }
  }

  void inicialization() async {
    /* String? t = await secureStorage.readSecureData('name');
    if (t != null) {
      _rxNavigateTo.value = "/home";
    } */
  }
}
