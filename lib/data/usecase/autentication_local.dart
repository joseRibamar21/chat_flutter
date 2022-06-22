import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationLocal {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> varifyAuthentican() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    print("Biometric" + canAuthenticateWithBiometrics.toString());
    print("///////////////////////////////////");
    final teste = await _auth.getAvailableBiometrics();
    teste.forEach(((element) => print(element)));
    print("///////////////////////////////////");
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    print("canAuthenticate" + canAuthenticate.toString());

    try {
      final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(biometricOnly: true));
      // ···
    } on PlatformException {
      // ...
    }
    return true;
  }
}
