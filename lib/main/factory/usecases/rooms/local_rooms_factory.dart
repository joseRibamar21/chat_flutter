import 'package:chat_flutter/infra/cache/cache.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/usecase/rooms/rooms.dart';
import '../../../../domain/usecase/usecase.dart';

LocalRoom makeGetLocalRooms() => GetLocalRooms(
    storage: GetLocalStorage(storage: GetStorage(), key: "rooms"));
