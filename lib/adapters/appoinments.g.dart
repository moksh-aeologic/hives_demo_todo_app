// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appoinments.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppoinmentAdapter extends TypeAdapter<Appoinment> {
  @override
  final int typeId = 1;

  @override
  Appoinment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Appoinment(
      fields[0] as String,
      fields[1] as String,
      fields[4] as DateTime,
      fields[3] as DateTime,
      fields[2] as String,
      fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Appoinment obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.creationDate)
      ..writeByte(5)
      ..write(obj.repeat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppoinmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
