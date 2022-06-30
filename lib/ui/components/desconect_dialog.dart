import 'package:flutter/material.dart';

void showDesconect(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("O tempo da sua conexão expirou!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  hideDesconect(context);
                },
                child: const Text("Entendi"))
          ],
        ),
      ),
    ),
  );
}

void hideDesconect(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/register", (route) => false);
  }
}
