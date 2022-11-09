// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhoneAdapter extends TypeAdapter<Phone> {
  @override
  final int typeId = 2;

  @override
  Phone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Phone(
      fields[0] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Phone obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
