// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substance_extra.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubstanceExtraAdapter extends TypeAdapter<SubstanceExtra> {
  @override
  final int typeId = 4;

  @override
  SubstanceExtra read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubstanceExtra(
      roaKey: fields[2] as String?,
      name: fields[0] as String?,
      lastROA: fields[3] as PsychoROA?,
    ).._oldLastROA = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, SubstanceExtra obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj._oldLastROA)
      ..writeByte(2)
      ..write(obj.roaKey)
      ..writeByte(3)
      ..write(obj.lastROA);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubstanceExtraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
