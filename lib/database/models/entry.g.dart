// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryAdapter extends TypeAdapter<Entry> {
  @override
  final int typeId = 1;

  @override
  Entry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entry(
      entryKey: fields[0] as String,
      stashKey: fields[1] as String,
      substanceName: fields[2] as String?,
      roa: fields[11] as PsychoROA?,
      amount: fields[4] as double?,
      multiplier: fields[5] as double?,
      externalUser: fields[6] as bool?,
      date: fields[7] as Date?,
      notes: fields[8] as String,
      noteKeys: (fields[10] as List?)?.cast<dynamic>(),
      substanceKey: fields[12] as int?,
      stashBoxKey: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Entry obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.entryKey)
      ..writeByte(1)
      ..write(obj.stashKey)
      ..writeByte(2)
      ..write(obj.substanceName)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.multiplier)
      ..writeByte(6)
      ..write(obj.externalUser)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(10)
      ..write(obj.noteKeys)
      ..writeByte(11)
      ..write(obj.roa)
      ..writeByte(12)
      ..write(obj.substanceKey)
      ..writeByte(13)
      ..write(obj.stashBoxKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
