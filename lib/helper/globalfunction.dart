import 'package:ateam/helper/trip.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void saveTrip(startlat, startlong, endlat, endlong, context,
    String startlocation, String endloca) {
  final double startLat = startlat;
  final double startLong = startlong;
  final double endLat = endlat;
  final double endLong = endlong;
  final String startLocation = startlocation;
  final String endlocation = endloca;

  final Trip trip = Trip(
    startLat: startLat,
    startLong: startLong,
    endLat: endLat,
    endLong: endLong,
    startlocation: startLocation,
    endlocation: endlocation,
  );

  final box = Hive.box<Trip>('trips');
  box.add(trip);
  Navigator.pop(context);
}
