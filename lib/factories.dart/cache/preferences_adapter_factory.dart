import '../../domain/usecase/usecase.dart';
import '../../infra/cache/cache.dart';

LocalStoragePreferences makeLocalStoragePreferences() =>
    LocalSharedPreferences();
