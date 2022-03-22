// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EffectAdapter extends TypeAdapter<Effect> {
  @override
  final int typeId = 24;

  @override
  Effect read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Effect(
      name: fields[0] as String?,
      category: fields[1] as EffectCategory?,
      subCategory: fields[2] as SubEffectCategory?,
      type: fields[3] as EffectType?,
      url: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Effect obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.subCategory)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EffectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Effect _$EffectFromJson(Map<String, dynamic> json) => Effect(
      name: json['name'] as String?,
      category: $enumDecodeNullable(_$EffectCategoryEnumMap, json['category']),
      subCategory:
          $enumDecodeNullable(_$SubEffectCategoryEnumMap, json['subCategory']),
      type: $enumDecodeNullable(_$EffectTypeEnumMap, json['type']),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$EffectToJson(Effect instance) => <String, dynamic>{
      'name': instance.name,
      'category': _$EffectCategoryEnumMap[instance.category],
      'subCategory': _$SubEffectCategoryEnumMap[instance.subCategory],
      'type': _$EffectTypeEnumMap[instance.type],
      'url': instance.url,
    };

const _$EffectCategoryEnumMap = {
  EffectCategory.Visual: 'Visual',
  EffectCategory.Cognitive: 'Cognitive',
  EffectCategory.Physical: 'Physical',
  EffectCategory.Auditory: 'Auditory',
  EffectCategory.Disconnective: 'Disconnective',
  EffectCategory.Tactile: 'Tactile',
  EffectCategory.SmellTaste: 'SmellTaste',
  EffectCategory.Multisensory: 'Multisensory',
};

const _$SubEffectCategoryEnumMap = {
  SubEffectCategory.Enhancements: 'Enhancements',
  SubEffectCategory.Suppressions: 'Suppressions',
  SubEffectCategory.Distortions: 'Distortions',
  SubEffectCategory.Geometry: 'Geometry',
  SubEffectCategory.Hallucinatory: 'Hallucinatory',
  SubEffectCategory.Novel: 'Novel',
  SubEffectCategory.Psychological: 'Psychological',
  SubEffectCategory.Transpersonal: 'Transpersonal',
  SubEffectCategory.Alterations: 'Alterations',
  SubEffectCategory.Cardiovascular: 'Cardiovascular',
  SubEffectCategory.Cerebrovascular: 'Cerebrovascular',
  SubEffectCategory.Bodily: 'Bodily',
  SubEffectCategory.Misc: 'Misc',
};

const _$EffectTypeEnumMap = {
  EffectType.Positive: 'Positive',
  EffectType.Neutral: 'Neutral',
  EffectType.Negative: 'Negative',
};
