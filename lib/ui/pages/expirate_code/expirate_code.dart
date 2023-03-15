import 'package:flutter/material.dart';

import '../../../presenter/presenter.dart';
import 'expirate_code_page.dart';

Widget makeExpirateCode() {
  return ExpirateCodePage(
    presenter: GetxExpirateCodePresenter(),
  );
}
