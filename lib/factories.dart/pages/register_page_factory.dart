import 'package:flutter/cupertino.dart';

import '../../presenter/presenter.dart';
import '../../ui/pages/pages.dart';

Widget makeRegisterPage() => RegisterPage(
      presenter: GetxRegisterPresenter(),
    );
