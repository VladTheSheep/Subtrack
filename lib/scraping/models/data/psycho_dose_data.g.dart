// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psycho_dose_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PsychoDoseDataAdapter extends TypeAdapter<PsychoDoseData> {
  @override
  final int typeId = 20;

  @override
  PsychoDoseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PsychoDoseData(
      min: fields[0] as double?,
      max: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, PsychoDoseData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.min)
      ..writeByte(1)
      ..write(obj.max);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PsychoDoseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychoDoseData _$PsychoDoseDataFromJson(Map<String, dynamic> json) =>
    PsychoDoseData(
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PsychoDoseDataToJson(PsychoDoseData instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };
