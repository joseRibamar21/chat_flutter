import 'package:get_storage/get_storage.dart';

import '../../../../data/usecase/usecase.dart';
import '../../../../domain/usecase/usecase.dart';
import '../../../../infra/cache/cache.dart';

LocalPreferences makeGetPreferencesStorage() => GetPreferencesStorage(
    storage: GetLocalStorage(storage: GetStorage(), key: "preferences"));
