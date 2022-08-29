
import 'package:objectbox/objectbox.dart';

import 'location.dart';
import 'objectbox.g.dart';

class LocationsRepository {
  late final Store _store;
  late final Box<LocationEntity> _box;

  List<LocationEntity> get locations => _box.getAll();

  Future initDB() async {
    _store = await openStore();
    _box = _store.box<LocationEntity>();
  }

  Future addLocation(LocationEntity location) async {
    await _box.putAsync(location);
  }
}