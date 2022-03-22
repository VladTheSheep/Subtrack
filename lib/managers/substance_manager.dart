import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imperium/consts/colors.dart';
import 'package:imperium/data/substance_stat.dart';
import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/category.dart';
import 'package:imperium/database/models/entry.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/scraping/models/psycho_roa.dart';
import 'package:imperium/utils/string_manipulation.dart';
import 'package:imperium/utils/themes.dart';
import 'package:imperium/widgets/category_badge.dart';

class SubstanceManager {
  static final SubstanceManager _substanceManager = SubstanceManager._internal();

  factory SubstanceManager() => _substanceManager;
  SubstanceManager._internal();

  static const int _lastUsedLimit = 10;
  List<SubstanceStat> drugsTried = [];
  Map<String, PsychoROA> lastUsedROAs = <String, PsychoROA>{};
  List<Substance> _lastUsedSubstances = [];

  Widget getCategoryIcon(
    Category category, {
    double iconSize = 32.0,
    Color? color,
    bool inactive = false,
    bool forceSimple = false,
    bool noClick = false,
  }) {
    if (forceSimple) {
      return SvgPicture.asset(
        category.iconPath!,
        color: color != null
            ? inactive
                ? Themes().getTheme().unselectedWidgetColor
                : category.color
            : color,
        height: iconSize,
        width: iconSize,
      );
    }

    return CategoryBadge(category: category, noText: true, size: iconSize, noClick: noClick, color: color);
  }

  void addTriedDrug(Substance substance) {
    SubstanceStat? subStat;

    for (final SubstanceStat stat in drugsTried) {
      if (stat.substance == substance) {
        subStat = stat;
        break;
      }
    }

    if (subStat == null) {
      drugsTried.add(SubstanceStat(substance, 1));
    } else {
      subStat.count = subStat.count + 1;
    }
  }

  Future<void> setLastUsedROAs(Map<String, PsychoROA> roas) async {
    print('SubstanceManager::setLastUsedROAs: Setting last used ROAs...');
    lastUsedROAs = roas;
    try {
      final List<Substance> substances = Log().getAllSubstances;
      if (substances.isNotEmpty) {
        for (final MapEntry<String, PsychoROA> roa in lastUsedROAs.entries) {
          Log().getSubstance(roa.key)!.setLastUsedROA(roa.value);
        }
      }
    } catch (e) {
      print('ERROR!! SubstanceManager::setLastUsedROAs: Something went wrong!');
    }
  }

  Future<void> setLastUsedSubstances() async {
    print('SubstanceManager::setLastUsedSubstances: Setting last used substances...');
    final List<Entry> entries = Log().getAllEntries.reversed.toList();
    _lastUsedSubstances = [];
    for (final Entry ent in entries) {
      final bool exists = _lastUsedSubstances.any((element) => element.name!.toLowerCase() == ent.getSubstance!.name!.toLowerCase());
      if ((_lastUsedSubstances.isEmpty || !exists) && _lastUsedSubstances.length < _lastUsedLimit) {
        _lastUsedSubstances.add(ent.getSubstance!);
      } else if (_lastUsedSubstances.length >= _lastUsedLimit) {
        break;
      }
    }
  }

  String sanitizeROA(String? roa) {
    String res;
    String? _temp = roa;
    int index = -1;
    if (roa != null) {
      index = findCharPos(_temp, ':', false);
      if (index != -1 && index == _temp!.length) {
        print("SubstanceManager::sanitizeROA: Fixing ROA string...");
        _temp = _temp.substring(0, index);
      }
    }

    final String? _roa = _temp;

    if (_roa == null || _roa == "Unknown" || _roa == "") {
      // print("Warning! SubstanceManager::sanitizeROA: Unknown ROA -- " + "'" + (roa == null ? "'null'" : roa) + "'");
      return "Unknown";
    }
    switch (_roa.toLowerCase()) {
      case "oral(pure)":
      case "oral_tea":
      case "oral":
        res = "Oral";
        break;

      case "insufflated":
      case "intranasal":
      case "insufflted":
      case "insufflation":
      case "insufflated(pure)":
        res = "Insufflation";
        break;

      case "smoked":
        res = "Smoked";
        break;

      case "vapourized":
      case "vapourised":
      case "vaporized":
        res = "Vaporized";
        break;

      case "rectal":
      case "plugged":
        res = "Plugged";
        break;

      case "im":
      case "intramuscular":
        res = "Intramuscular";
        break;

      case "iv":
      case "intravenously":
      case "intravenous":
        res = "Intravenous";
        break;

      case "sublingually":
      case "sublingual":
      case "sublingual/buccal":
        res = "Sublingual";
        break;

      case "transdermal":
        res = "Transdermal";
        break;

      case "inhaled":
      case "inhalation":
        res = "Inhalation";
        break;

      case "subcutaneous":
        res = "Subcutaneous";
        break;

      default:
        // print("Warning! SubstanceManager::sanitizeROA: Unknown ROA -- " + (roa == null ? "'null'" : roa));
        return "Unknown";
    }

    if (res.isNotEmpty && res[res.length - 1] == ':') res = res.substring(0, res.length - 1);

    return firstCharUppercase(res);
  }

  Future<void> setSubstances(List<Substance>? input, {bool clearAndUpdate = false}) async {
    if (clearAndUpdate) {
      await Log().substances.clear();
      await Log().substances.addAll(input!);

      if (Log().entries.isOpen && Log().entries.isNotEmpty) {
        for (final Entry? entry in Log().entries.values) {
          if (entry!.getSubstance != null) entry.getSubstance!.timesUsed++;
        }
      }
    }
  }

  Future<void> setCategories(Map<String?, Category> input) async {
    await Log().categories.clear();
    await Log().categories.addAll(input.values.toList());
    await Log().categories.addAll(addCustomCategories());

    for (final Category cat in Log().categories.values) {
      await setCategoriesIcon(category: cat);

      if (cat.name == 'tentative' ||
          cat.name == 'research-chemical' ||
          cat.name == 'inactive' ||
          cat.name == 'habit-forming' ||
          cat.name == 'common' ||
          cat.name == 'custom') cat.misc = true;

      await cat.save();
    }
  }

  Future<void> setCategoriesIcon({Category? category}) async {
    if (category == null) {
      for (final Category cat in Log().categories.values) {
        await _setCategoryIcon(cat);
      }
    } else {
      await _setCategoryIcon(category);
    }
  }

  List<Category> addCustomCategories() {
    return [
      // Category(
      //   name: 'custom',
      //   description: 'A custom substance made by the user',
      // ),
      Category(
        name: 'cannabinoid',
        description:
            "A common and widely used psychoactive plant, which is beginning to enjoy legal status for medical and even recreational use in some parts of the world. Usually smoked or eaten, primary effects are relaxation and an affinity towards food - a state described as being 'stoned.'",
      ),
      Category(
        name: 'SSRI',
        description:
            'Selective serotonin reuptake inhibitors (SSRIs) are a class of drugs that are typically used as antidepressants in the treatment of major depressive disorder, anxiety disorders, and other psychological conditions.',
      ),
      Category(
        name: 'antipsychotic',
        description:
            'Antipsychotics (also known as neuroleptics or major tranquilizers) are a class of psychiatric medication primarily used to manage psychosis (including delusions, hallucinations, or disordered thought), particularly in schizophrenia and bipolar disorder.',
      )
    ];
  }

  Future<void> _setCategoryIcon(Category category) async {
    switch (category.name!.toLowerCase()) {
      case 'cannabinoid':
        category.iconPath = 'assets/icons/cannabis.svg';
        category.color = cannabisColorMat;
        break;

      case 'custom':
        category.iconPath = 'assets/icons/custom.svg';
        category.color = dissoColorMat;
        break;

      case 'psychedelic':
        category.iconPath = 'assets/icons/psychedelic.svg';
        category.color = psychColorMat;
        break;

      case 'dissociative':
        category.iconPath = 'assets/icons/disso.svg';
        category.color = dissoColorMat;
        break;

      case 'stimulant':
        category.iconPath = 'assets/icons/stimulant.svg';
        category.color = researchColorMat;
        break;

      case 'depressant':
        category.iconPath = 'assets/icons/depressant.svg';
        category.color = depressantColorMat;
        break;

      case 'benzodiazepine':
        category.iconPath = 'assets/icons/benzo.svg';
        category.color = depressantColorMat;
        break;

      case 'barbiturate':
        category.iconPath = 'assets/icons/barbiturate.svg';
        category.color = depressantColorMat;
        break;

      case 'nootropic':
        category.iconPath = 'assets/icons/nootropic.svg';
        category.color = nootropicColorMat;
        break;

      case 'supplement':
        category.iconPath = 'assets/icons/supplement.svg';
        category.color = nootropicColorMat;
        break;

      case 'empathogen':
        category.iconPath = 'assets/icons/heart.svg';
        category.color = empathogenColorMat;
        break;

      case 'deliriant':
        category.iconPath = 'assets/icons/deliriant.svg';
        category.color = deliriantColorMat;
        break;

      case 'opioid':
        category.iconPath = 'assets/icons/opium.svg';
        category.color = opioidColorMat;
        break;

      case 'habit-forming':
        category.iconPath = 'assets/icons/habit.svg';
        category.color = habitColorMat;
        break;

      case 'common':
        category.iconPath = 'assets/icons/common.svg';
        category.color = Colors.white;
        break;

      case 'research-chemical':
        category.iconPath = 'assets/icons/research.svg';
        category.color = stimColorMat;
        break;

      case 'tentative':
        category.iconPath = 'assets/icons/tentative.svg';
        category.color = tentativeColorMat;
        break;

      case 'ssri':
        category.iconPath = 'assets/icons/ssri.svg';
        category.color = ssriColorMat;
        break;

      case 'antipsychotic':
        category.iconPath = 'assets/icons/antipsychotic.svg';
        category.color = antipsychoticColorMat;
        break;

      default:
        category.iconPath = 'assets/icons/unknown.svg';
        category.color = Colors.white;
        break;
    }

    await category.save();
  }
}
