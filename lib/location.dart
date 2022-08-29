import 'package:objectbox/objectbox.dart';

@Entity()
class LocationEntity {
  @Id()
  int id;
  String name;

  LocationEntity({
    this.id = 0,
    required this.name,
  });
}