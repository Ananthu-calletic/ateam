// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 0;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      startLat: fields[0] as double,
      startLong: fields[1] as double,
      endLat: fields[2] as double,
      endLong: fields[3] as double,
      startlocation: fields[4] as String,
      endlocation: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.startLat)
      ..writeByte(1)
      ..write(obj.startLong)
      ..writeByte(2)
      ..write(obj.endLat)
      ..writeByte(3)
      ..write(obj.endLong)
      ..writeByte(4)
      ..write(obj.startlocation)
      ..writeByte(5)
      ..write(obj.endlocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
