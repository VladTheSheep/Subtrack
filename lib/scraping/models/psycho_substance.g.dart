// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psycho_substance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsychoSubstance _$PsychoSubstanceFromJson(Map<String, dynamic> json) =>
    PsychoSubstance(
      name: json['name'] as String?,
      psychoactive: json['class'] as Map<String, dynamic>?,
      roas: (json['roas'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, PsychoROA.fromJson(e as Map<String, dynamic>)),
      ),
      effects: json['effects'] as Map<String, dynamic>?,
      prettyName: json['pretty_name'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      links: json['links'] as Map<String, dynamic>?,
      aliases:
          (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList(),
      avoid: json['avoid'] as String?,
      bioavailability: json['bioavailability'] as String?,
      detection: json['detection'] as String?,
      halflife: json['halflife'] as String?,
      marquis: json['marquis'] as String?,
      interactions: json['interactions'] as Map<String, dynamic>?,
      sources: json['sources'] as Map<String, dynamic>?,
      doseNote: json['dose_note'] as String?,
      summary: json['summary'] as String?,
      testkits: json['testkits'] as String?,
      warning: json['warning'] as String?,
    );

Map<String, dynamic> _$PsychoSubstanceToJson(PsychoSubstance instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('pretty_name', instance.prettyName);
  writeNotNull('class', instance.psychoactive);
  writeNotNull('roas', instance.roas);
  writeNotNull('effects', instance.effects);
  writeNotNull('interactions', instance.interactions);
  writeNotNull('sources', instance.sources);
  writeNotNull('categories', instance.categories);
  writeNotNull('links', instance.links);
  writeNotNull('aliases', instance.aliases);
  writeNotNull('avoid', instance.avoid);
  writeNotNull('bioavailability', instance.bioavailability);
  writeNotNull('detection', instance.detection);
  writeNotNull('halflife', instance.halflife);
  writeNotNull('marquis', instance.marquis);
  writeNotNull('summary', instance.summary);
  writeNotNull('testkits', instance.testkits);
  writeNotNull('warning', instance.warning);
  writeNotNull('dose_note', instance.doseNote);
  return val;
}
