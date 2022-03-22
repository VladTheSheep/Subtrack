// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InteractionAdapter extends TypeAdapter<Interaction> {
  @override
  final int typeId = 14;

  @override
  Interaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Interaction(
      name: fields[0] as String?,
      status: fields[2] as InteractionType?,
      note: fields[3] as String?,
    )..altSub = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, Interaction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.altSub)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interaction _$InteractionFromJson(Map<String, dynamic> json) => Interaction(
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$InteractionTypeEnumMap, json['status']),
      note: json['note'] as String?,
    )..altSub = json['altSub'] as String?;

Map<String, dynamic> _$InteractionToJson(Interaction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'altSub': instance.altSub,
      'status': _$InteractionTypeEnumMap[instance.status],
      'note': instance.note,
    };

const _$InteractionTypeEnumMap = {
  InteractionType.Caution: 'Caution',
  InteractionType.Unsafe: 'Unsafe',
  InteractionType.Dangerous: 'Dangerous',
  InteractionType.Synergy: 'Synergy',
  InteractionType.Decrease: 'Decrease',
};
