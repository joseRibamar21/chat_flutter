import 'package:flutter/material.dart';

import '../components/components.dart';

mixin DesconectMixin {
  void handleDesconect(BuildContext context, Stream<String?> stream) {
    stream.listen((event) {
      if (event != null) {
        showDesconect(context, event);
      }
    });
  }
}
