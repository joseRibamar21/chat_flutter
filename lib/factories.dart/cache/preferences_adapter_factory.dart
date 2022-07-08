import '../../data/usecase/usecase.dart';
import '../../domain/usecase/usecase.dart';
import '../../infra/cache/cache.dart';

LocalPreferences makePreferences() =>
    Preferences(local: LocalSharedPreferences());
