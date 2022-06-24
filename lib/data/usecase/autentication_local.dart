import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationLocal {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> varifyAuthentican() async {
    bool didAuthenticate = false;
    try {
      didAuthenticate = await _auth.authenticate(
          localizedReason: 'Por favor, autentique-se para retornar a sala.',
          options: const AuthenticationOptions(
              biometricOnly: true,
              sensitiveTransaction: true,
              useErrorDialogs: false,
              stickyAuth: true));
    } on PlatformException {
      didAuthenticate = false;
    }
    return !didAuthenticate;
  }
}
