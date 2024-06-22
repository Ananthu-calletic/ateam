import 'package:hive/hive.dart';
part 'trip.g.dart';

@HiveType(typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  double startLat;

  @HiveField(1)
  double startLong;

  @HiveField(2)
  double endLat;

  @HiveField(3)
  double endLong;
  @HiveField(4)
  String startlocation;

  @HiveField(5)
  String endlocation;

  Trip({
    required this.startLat,
    required this.startLong,
    required this.endLat,
    required this.endLong,
    required this.startlocation,
    required this.endlocation,
  });
}
