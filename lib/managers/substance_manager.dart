import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imperium/database/models/category.dart';
import 'package:imperium/utils/string_manipulation.dart';
import 'package:imperium/utils/themes.dart';
import 'package:imperium/widgets/category_badge.dart';

class SubstanceManager {
  static final SubstanceManager _substanceManager = SubstanceManager._internal();

  factory SubstanceManager() => _substanceManager;
  SubstanceManager._internal();

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
}
