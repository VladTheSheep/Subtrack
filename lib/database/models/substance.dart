import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/category.dart';
import 'package:imperium/database/models/effect.dart';
import 'package:imperium/database/models/interaction.dart';
import 'package:imperium/managers/effects_manager.dart';
import 'package:imperium/managers/substance_manager.dart';
import 'package:imperium/scraping/models/psycho_roa.dart';
import 'package:imperium/scraping/models/psycho_substance.dart';
import 'package:imperium/utils/string_manipulation.dart';

part 'substance.g.dart';

@HiveType(typeId: 6)
class Substance extends HiveObject {
  Substance({
    this.avoid = '',
    this.bioavailability = '',
    this.custom = false,
    this.detection = '',
    this.doseNote = '',
    this.halflife = '',
    this.marquis = '',
    this.name = '',
    this.interactions,
    this.prettyName = '',
    this.summary = '',
    this.testkits = '',
    this.warning = '',
    this.aliases,
    this.categories = const [],
    this.roas,
    this.effects,
    this.links,
    this.sources,
  }) {
    aliases ??= [];
    interactions ??= {};
    effects ??= [];
  }

  static final Substance _substance = Substance._internal();

  factory Substance.singleton() => _substance;
  Substance._internal();

  factory Substance.fromJson(Map<String, dynamic> json) => Substance(
        avoid: json["avoid"] as String?,
        bioavailability: json["bioavailability"] as String?,
        custom: json["custom"] as bool?,
        detection: json["detection"] as String?,
        doseNote: json["doseNote"] as String?,
        halflife: json["halflife"] as String?,
        marquis: json["marquis"] as String?,
        name: json["name"] as String?,
        prettyName: json["prettyName"] as String?,
        interactions: json["interactions"] as Map<String, List<Interaction>>,
        summary: json["summary"] as String?,
        testkits: json["testkits"] as String?,
        links: json["links"] as Map<String, dynamic>,
        sources: json["sources"] as Map<String, dynamic>,
        warning: json["warning"] as String?,
        aliases: json["aliases"] as List<String?>,
        roas: json["roas"] as List<PsychoROA>,
        categories: json["categories"] as List<Category>,
        effects: json["effects"] as List<Effect>,
      )..categories = json["categories"] as List<Category>;

  factory Substance.fromParsed(PsychoSubstance sub) {
    sub = _substance._setCustomSubstanceCategories(sub);
    final Substance _sub = Substance(
      name: sub.name,
      avoid: sub.avoid,
      bioavailability: sub.bioavailability,
      detection: sub.detection,
      doseNote: sub.doseNote,
      halflife: sub.halflife,
      marquis: sub.marquis,
      prettyName: sub.prettyName,
      summary: sub.summary,
      testkits: sub.testkits,
      warning: sub.warning,
      effects: EffectsManager().parseEffects(sub.effects),
      interactions: _substance._parseInteractions(sub.interactions),
      aliases: sub.aliases,
      roas: sub.roas!.values.toList(),
      links: sub.links,
      sources: sub.sources,
    )..categories = _substance._parseSubstanceCategories(sub.categories);

    return _substance._overridePrimaryCategory(_sub);
  }

  @HiveField(0)
  String? avoid = '';
  @HiveField(1)
  String? bioavailability = '';
  @HiveField(2)
  bool? custom = false;
  @HiveField(3)
  String? detection = '';
  @HiveField(4)
  String? doseNote = '';

  // @HiveField(6)
  // String? doseUnit = '';

  @HiveField(8)
  String? halflife = '';
  // @HiveField(9)
  // Map<String, List<Interaction>>? interactions = Map<String, List<Interaction>>();
  @HiveField(10)
  String? marquis = '';
  @HiveField(11)
  String? name = '';
  @HiveField(12)
  String? prettyName = '';
  // @HiveField(13)
  // String? psychonautWikiUrl = '';
  @HiveField(14)
  String? summary = '';
  @HiveField(15)
  String? testkits = '';
  // @HiveField(16)
  // String? tripSitUrl = '';
  @HiveField(17)
  String? warning = '';
  @HiveField(18)
  List<PsychoROA?>? roas;
  @HiveField(19)
  List<String?>? aliases = [];
  @HiveField(20)
  List<Category> categories = [];
  @HiveField(21)
  List<Effect?>? effects = [];
  // @HiveField(22)
  // List<String?>? rawCategories = [];
  // @HiveField(23)
  // List<String?>? rawEffects = [];
  @HiveField(24)
  Map<String, dynamic>? links;
  @HiveField(25)
  Map<String, dynamic>? sources;
  @HiveField(26)
  Map<String, List<Interaction>>? interactions = <String, List<Interaction>>{};
  int timesUsed = 0;

  PsychoROA? _lastUsedROA;

  Map<String, dynamic> toJson() => {
        "avoid": avoid,
        "bioavailability": bioavailability,
        "custom": custom,
        "detection": detection,
        "doseNote": doseNote,
        "halflife": halflife,
        "marquis": marquis,
        "name": name,
        "prettyName": prettyName,
        "interactions": interactions,
        "summary": summary,
        "testkits": testkits,
        "warning": warning,
        "aliases": aliases,
        "links": links,
        "sources": sources,
        "roas": roas,
        "categories": categories,
        "effects": effects,
      };

  List<Category> _parseSubstanceCategories(List<String>? list) {
    final List<Category?> categories = Log().getAllCategories;
    final List<Category> result = [];
    final List<Category> miscCategories = [];

    if (list == null) return result;
    for (final String elem in list) {
      if (elem.isNotEmpty) {
        Category? _temp;
        try {
          _temp = categories.firstWhere((element) => element?.name?.toLowerCase() == elem.toLowerCase());
          if (!_temp!.misc!) {
            result.add(_temp);
          } else {
            miscCategories.add(_temp);
          }
        } catch (e) {
          print("ERROR! Substance::_parseSubstancesCategories: No matching category for '$elem' -- $e");
        }
      }
    }

    result.addAll(miscCategories);

    return result;
  }

  Substance _overridePrimaryCategory(Substance sub) {
    if (sub.getName!.toLowerCase() == 'mdma') {
      final int index = sub.categories.indexWhere((element) => element.name!.toLowerCase() == 'empathogen');
      if (index != -1) {
        final Category cat = sub.categories[index];
        sub.categories.removeAt(index);
        sub.categories.insert(0, cat);
      }
    }
    return sub;
  }

  PsychoSubstance _setCustomSubstanceCategories(PsychoSubstance sub) {
    switch (sub.name!.toLowerCase()) {
      case 'cannabis':
        List<String>? temp = sub.categories;
        temp ??= [];
        if (!temp.contains('cannabinoid')) {
          temp.insert(0, 'cannabinoid');
          sub.categories = temp;
        }
        break;
    }
    return sub;
  }

  Map<String, List<Interaction>> _parseInteractions(Map<String, dynamic>? input) {
    if (input == null) throw "NO INTERACTIONS";
    final Map<String, List<Interaction>> result = {};
    for (final MapEntry<String, dynamic> entry in input.entries) {
      for (final MapEntry<String, dynamic> inner in entry.value.entries) {
        if (result[entry.key] == null) result[entry.key] = [];
        result[entry.key]!.add(
          Interaction(
            name: inner.key,
            status: Interaction.stringToInteractionType(entry.key),
            note: inner.value.toString(),
          ),
        );
      }
    }
    return result;
  }

  set lastUsedROA(PsychoROA? roa) => _lastUsedROA = roa;
  PsychoROA? get lastUsedROA => _lastUsedROA;

  Category get getPrimaryCategory => categories.isNotEmpty ? categories.first : Category(name: 'Unknown');
  Color get getPrimaryCategoryColor {
    if (categories.isNotEmpty) return categories.first.color;

    print('ERROR!! Substance::getPrimaryCategoryColor: No categories found! Returning grey instead...');
    return Colors.grey;
  }

  Widget? getCategoryIcon({double size = 32.0}) => SubstanceManager().getCategoryIcon(getPrimaryCategory, iconSize: size);
  List<Category> get getCategories => categories.toList();
  String? get getName => name!.length > 1 ? name : "Unknown";
  String? get getSummary => summary != null && summary!.isNotEmpty ? summary : "No summary found";

  String get getDoseUnit {
    if (roas != null && roas!.isNotEmpty) return roas!.first!.dose!.unit ?? 'n/a';
    return 'n/a';
  }

  String? get getAvoid => avoid != null && avoid!.isNotEmpty ? avoid : "No avoid data found";
  String? get getHalfLife => halflife != null && halflife!.isNotEmpty ? halflife : "No half-life data found";
  String? get getBioavailability => bioavailability != null && bioavailability!.isNotEmpty ? bioavailability : "No bioavailability data found";
  String? get getTestkits => testkits != null && testkits!.isNotEmpty ? testkits : "No testkit data found";

  String getAliases({bool noSpace = false, String separator = ','}) {
    final StringBuffer result = StringBuffer();

    if (aliases!.isNotEmpty) {
      for (int i = 0; i < aliases!.length; ++i) {
        result.write(firstCharUppercase(aliases![i]!));

        if (aliases![i] != aliases!.last) result.write(noSpace ? separator : '$separator ');
      }
    } else {
      result.write("No aliases found");
    }

    return result.toString();
  }

  List<String?> get getAliasList => List<String?>.from(aliases!);

  List<Effect?>? get getEffectsList => effects;
}
