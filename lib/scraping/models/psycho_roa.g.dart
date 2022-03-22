// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psycho_roa.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PsychoROAAdapter extends TypeAdapter<PsychoROA> {
  @override
  final int typeId = 18;

  @override
  PsychoROA read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PsychoROA(
      name: fields[1] as String?,
      dose: fields[2] as PsychoDose?,
      afterglow: fields[9] as PsychoDurationData?,
      comeup: fields[6] as PsychoDurationData?,
      onset: fields[5] as PsychoDurationData?,
      offset: fields[8] as PsychoDurationData?,
      peak: fields[7] as PsychoDurationData?,
      total: fields[4] as PsychoDurationData?,
    )..iconPath = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, PsychoROA obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.iconPath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dose)
      ..writeByte(4)
      ..write(obj.total)
      ..writeByte(5)
      ..write(obj.onset)
      ..writeByte(6)
      ..write(obj.comeup)
      ..writeByte(7)
      ..write(obj.peak)
      ..writeByte(8)
      ..write(obj.offset)
      ..writeByte(9)
      ..write(obj.afterglow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PsychoROAAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychoROA _$PsychoROAFromJson(Map<String, dynamic> json) => PsychoROA(
      name: json['name'] as String?,
      dose: json['dose'] == null ? null : PsychoDose.fromJson(json['dose'] as Map<String, dynamic>),
      afterglow: json['afterglow'] == null
          ? null
          : PsychoDurationData.fromJson(
              json['afterglow'] as Map<String, dynamic>,
            ),
      comeup: json['comeup'] == null ? null : PsychoDurationData.fromJson(json['comeup'] as Map<String, dynamic>),
      onset: json['onset'] == null ? null : PsychoDurationData.fromJson(json['onset'] as Map<String, dynamic>),
      offset: json['offset'] == null ? null : PsychoDurationData.fromJson(json['offset'] as Map<String, dynamic>),
      peak: json['peak'] == null ? null : PsychoDurationData.fromJson(json['peak'] as Map<String, dynamic>),
      total: json['total'] == null ? null : PsychoDurationData.fromJson(json['total'] as Map<String, dynamic>),
    )..iconPath = json['iconPath'] as String?;

Map<String, dynamic> _$PsychoROAToJson(PsychoROA instance) => <String, dynamic>{
      'iconPath': instance.iconPath,
      'name': instance.name,
      'dose': instance.dose,
      'total': instance.total,
      'onset': instance.onset,
      'comeup': instance.comeup,
      'peak': instance.peak,
      'offset': instance.offset,
      'afterglow': instance.afterglow,
    };
