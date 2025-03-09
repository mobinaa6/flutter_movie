// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdvertismentAdapter extends TypeAdapter<Advertisment> {
  @override
  final int typeId = 1;

  @override
  Advertisment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Advertisment(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Advertisment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.urlSite)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdvertismentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
