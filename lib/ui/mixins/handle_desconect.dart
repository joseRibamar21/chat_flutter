import 'package:flutter/material.dart';

import '../components/components.dart';

mixin DesconectMixin {
  void handleDesconect(BuildContext context, Stream<bool> stream) {
    stream.listen((isLoading) {
      if (isLoading == true) {
        showDesconect(context);
      }
    });
  }
}
