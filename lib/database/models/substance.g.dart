// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubstanceAdapter extends TypeAdapter<Substance> {
  @override
  final int typeId = 6;

  @override
  Substance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Substance(
      avoid: fields[0] as String?,
      bioavailability: fields[1] as String?,
      custom: fields[2] as bool?,
      detection: fields[3] as String?,
      doseNote: fields[4] as String?,
      halflife: fields[8] as String?,
      marquis: fields[10] as String?,
      name: fields[11] as String?,
      interactions: (fields[26] as Map?)?.map(
        (dynamic k, dynamic v) => MapEntry(k as String, (v as List).cast<Interaction>()),
      ),
      prettyName: fields[12] as String?,
      summary: fields[14] as String?,
      testkits: fields[15] as String?,
      warning: fields[17] as String?,
      aliases: (fields[19] as List?)?.cast<String?>(),
      categories: (fields[20] as List).cast<Category>(),
      roas: (fields[18] as List?)?.cast<PsychoROA?>(),
      effects: (fields[21] as List?)?.cast<Effect?>(),
      links: (fields[24] as Map?)?.cast<String, dynamic>(),
      sources: (fields[25] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Substance obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.avoid)
      ..writeByte(1)
      ..write(obj.bioavailability)
      ..writeByte(2)
      ..write(obj.custom)
      ..writeByte(3)
      ..write(obj.detection)
      ..writeByte(4)
      ..write(obj.doseNote)
      ..writeByte(8)
      ..write(obj.halflife)
      ..writeByte(10)
      ..write(obj.marquis)
      ..writeByte(11)
      ..write(obj.name)
      ..writeByte(12)
      ..write(obj.prettyName)
      ..writeByte(14)
      ..write(obj.summary)
      ..writeByte(15)
      ..write(obj.testkits)
      ..writeByte(17)
      ..write(obj.warning)
      ..writeByte(18)
      ..write(obj.roas)
      ..writeByte(19)
      ..write(obj.aliases)
      ..writeByte(20)
      ..write(obj.categories)
      ..writeByte(21)
      ..write(obj.effects)
      ..writeByte(24)
      ..write(obj.links)
      ..writeByte(25)
      ..write(obj.sources)
      ..writeByte(26)
      ..write(obj.interactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SubstanceAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
