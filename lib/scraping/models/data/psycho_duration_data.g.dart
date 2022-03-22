// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psycho_duration_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PsychoDurationDataAdapter extends TypeAdapter<PsychoDurationData> {
  @override
  final int typeId = 22;

  @override
  PsychoDurationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PsychoDurationData(
      min: fields[0] as double?,
      max: fields[1] as double?,
      unit: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PsychoDurationData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.min)
      ..writeByte(1)
      ..write(obj.max)
      ..writeByte(2)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PsychoDurationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychoDurationData _$PsychoDurationDataFromJson(Map<String, dynamic> json) =>
    PsychoDurationData(
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$PsychoDurationDataToJson(PsychoDurationData instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'unit': instance.unit,
    };
