import 'package:flutter/material.dart';

import '../../presenter/presenter.dart';
import '../../ui/pages/pages.dart';
import '../cache/cache.dart';

Widget makeRegisterPage() => RegisterPage(
      presenter: GetxRegisterPresenter(preferences: makePreferences()),
    );
