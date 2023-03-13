import 'package:flutter/material.dart';

void showDesconect(BuildContext context, String title) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
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
    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  }
}
