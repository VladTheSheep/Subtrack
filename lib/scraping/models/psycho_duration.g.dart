// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psycho_duration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PsychoDurationAdapter extends TypeAdapter<PsychoDuration> {
  @override
  final int typeId = 21;

  @override
  PsychoDuration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PsychoDuration(
      total: fields[0] as PsychoDurationData?,
      onset: fields[1] as PsychoDurationData?,
      comeup: fields[2] as PsychoDurationData?,
      peak: fields[3] as PsychoDurationData?,
      offset: fields[4] as PsychoDurationData?,
      afterglow: fields[5] as PsychoDurationData?,
    );
  }

  @override
  void write(BinaryWriter writer, PsychoDuration obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.onset)
      ..writeByte(2)
      ..write(obj.comeup)
      ..writeByte(3)
      ..write(obj.peak)
      ..writeByte(4)
      ..write(obj.offset)
      ..writeByte(5)
      ..write(obj.afterglow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PsychoDurationAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychoDuration _$PsychoDurationFromJson(Map<String, dynamic> json) => PsychoDuration(
      total: json['total'] == null ? null : PsychoDurationData.fromJson(json['total'] as Map<String, dynamic>),
      onset: json['onset'] == null ? null : PsychoDurationData.fromJson(json['onset'] as Map<String, dynamic>),
      comeup: json['comeup'] == null ? null : PsychoDurationData.fromJson(json['comeup'] as Map<String, dynamic>),
      peak: json['peak'] == null ? null : PsychoDurationData.fromJson(json['peak'] as Map<String, dynamic>),
      offset: json['offset'] == null ? null : PsychoDurationData.fromJson(json['offset'] as Map<String, dynamic>),
      afterglow: json['afterglow'] == null
          ? null
          : PsychoDurationData.fromJson(
              json['afterglow'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PsychoDurationToJson(PsychoDuration instance) => <String, dynamic>{
      'total': instance.total,
      'onset': instance.onset,
      'comeup': instance.comeup,
      'peak': instance.peak,
      'offset': instance.offset,
      'afterglow': instance.afterglow,
    };
