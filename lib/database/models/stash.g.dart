// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stash.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StashAdapter extends TypeAdapter<Stash> {
  @override
  final int typeId = 0;

  @override
  Stash read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stash(
      stashKey: fields[0] as String,
      alias: fields[1] as String?,
      source: fields[3] as String?,
      description: fields[4] as String,
      created: fields[5] as Date?,
      amount: fields[6] as double,
      multiplier: fields[7] as double,
      totalUsed: fields[8] as double,
      archived: fields[9] as bool,
      archiveDate: fields[10] as Date?,
      lastUsed: fields[11] as String?,
      entryKeys: (fields[12] as List?)?.cast<dynamic>(),
      substanceName: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Stash obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.stashKey)
      ..writeByte(1)
      ..write(obj.alias)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.created)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.multiplier)
      ..writeByte(8)
      ..write(obj.totalUsed)
      ..writeByte(9)
      ..write(obj.archived)
      ..writeByte(10)
      ..write(obj.archiveDate)
      ..writeByte(11)
      ..write(obj.lastUsed)
      ..writeByte(12)
      ..write(obj.entryKeys)
      ..writeByte(13)
      ..write(obj.substanceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StashAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
