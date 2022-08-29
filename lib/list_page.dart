import 'package:flutter/material.dart';
import 'package:maps_example/saved_location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'location.dart';
import 'locations_repository.dart';

final locations = <SavedLocation>[];

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final _locationsRepo = LocationsRepository();
  late var _locations = <LocationEntity>[];

  @override
  void initState() {
    super.initState();
    _locationsRepo.initDB().whenComplete(
        () => setState(() => _locations = _locationsRepo.locations));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
      ),
      body: ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(
            _locations[i].name,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = (await Navigator.pushNamed(context, 'yandex_map'))
              as SavedLocation?;
          if (result == null) return;
          _locationsRepo.addLocation(LocationEntity(name: result.name));

          setState(() {
            _locations = _locationsRepo.locations;
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
