// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psycho_dose.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PsychoDoseAdapter extends TypeAdapter<PsychoDose> {
  @override
  final int typeId = 19;

  @override
  PsychoDose read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PsychoDose(
      unit: fields[0] as String?,
      threshold: fields[1] as double?,
      light: fields[2] as PsychoDoseData?,
      common: fields[3] as PsychoDoseData?,
      strong: fields[4] as PsychoDoseData?,
      heavy: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, PsychoDose obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.unit)
      ..writeByte(1)
      ..write(obj.threshold)
      ..writeByte(2)
      ..write(obj.light)
      ..writeByte(3)
      ..write(obj.common)
      ..writeByte(4)
      ..write(obj.strong)
      ..writeByte(5)
      ..write(obj.heavy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PsychoDoseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychoDose _$PsychoDoseFromJson(Map<String, dynamic> json) => PsychoDose(
      unit: json['unit'] as String?,
      threshold: (json['threshold'] as num?)?.toDouble(),
      light: json['light'] == null
          ? null
          : PsychoDoseData.fromJson(json['light'] as Map<String, dynamic>),
      common: json['common'] == null
          ? null
          : PsychoDoseData.fromJson(json['common'] as Map<String, dynamic>),
      strong: json['strong'] == null
          ? null
          : PsychoDoseData.fromJson(json['strong'] as Map<String, dynamic>),
      heavy: (json['heavy'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PsychoDoseToJson(PsychoDose instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'threshold': instance.threshold,
      'light': instance.light,
      'common': instance.common,
      'strong': instance.strong,
      'heavy': instance.heavy,
    };
