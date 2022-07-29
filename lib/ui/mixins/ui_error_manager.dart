import 'package:flutter/material.dart';
import '../components/components.dart';

mixin UIErrorManager {
  void handleUIError(BuildContext context, Stream<String?> stream) {
    stream.listen((error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (error != null) {
        showErrorMessage(context, error);
      }
    });
  }
}
