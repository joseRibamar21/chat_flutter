import 'package:get_storage/get_storage.dart';

import '../../../../data/usecase/rooms/rooms.dart';
import '../../../../domain/usecase/usecase.dart';
import '../../../../infra/cache/cache.dart';

LocalRoom makeGetLocalRooms() => GetLocalRooms(
    storage: GetLocalStorage(storage: GetStorage(), key: "rooms"));
