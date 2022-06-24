import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationLocal {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> varifyCanAuthentican() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    final List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();

/*     print(canAuthenticateWithBiometrics);
    print(canAuthenticate);
    print(availableBiometrics.isNotEmpty); */
    return canAuthenticateWithBiometrics &&
        canAuthenticate &&
        availableBiometrics.isNotEmpty;
  }

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
      throw false;
    }
    return !didAuthenticate;
  }
}
