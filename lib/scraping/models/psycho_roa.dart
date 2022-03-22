import 'package:hive/hive.dart';
import 'package:imperium/managers/substance_manager.dart';
import 'package:imperium/scraping/models/data/psycho_duration_data.dart';
import 'package:imperium/scraping/models/psycho_dose.dart';
import 'package:imperium/utils/string_manipulation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'psycho_roa.g.dart';

@JsonSerializable()
@HiveType(typeId: 18)
class PsychoROA {
  PsychoROA({this.name, this.dose, this.afterglow, this.comeup, this.onset, this.offset, this.peak, this.total}) {
    setROA(name);
    // if (duration == null) duration = PsychoDuration();
    dose ??= PsychoDose();
  }

  factory PsychoROA.fromJson(Map<String, dynamic> json) => _$PsychoROAFromJson(json);

  @HiveField(0)
  String? iconPath;

  @HiveField(1)
  String? name;
  @HiveField(2)
  PsychoDose? dose;
  // @HiveField(3)
  // PsychoDuration? duration;
  @HiveField(4)
  PsychoDurationData? total;
  @HiveField(5)
  PsychoDurationData? onset;
  @HiveField(6)
  PsychoDurationData? comeup;
  @HiveField(7)
  PsychoDurationData? peak;
  @HiveField(8)
  PsychoDurationData? offset;
  @HiveField(9)
  PsychoDurationData? afterglow;

  String getName() {
    if (name!.isNotEmpty) return firstCharUppercase(name!);
    return 'Not set';
  }

  void setROA(String? name) {
    final String _name = SubstanceManager().sanitizeROA(this.name);
    if (_name != 'Unknown') {
      switch (_name.toLowerCase()) {
        case "oral":
          iconPath = "assets/icons/oral.svg";
          break;

        case "insufflation":
          iconPath = "assets/icons/snorting.svg";
          break;

        case "smoked":
          iconPath = "assets/icons/smoking.svg";
          break;

        case "vaporized":
          iconPath = "assets/icons/vapor.svg";
          break;

        case "plugged":
          iconPath = "assets/icons/plugged.svg";
          break;

        case "intramuscular":
          iconPath = "assets/icons/im.svg";
          break;

        case "intravenous":
          iconPath = "assets/icons/iv.svg";
          break;

        case "sublingual":
          iconPath = "assets/icons/sublingual.svg";
          break;

        case "transdermal":
          iconPath = "assets/icons/transdermal.svg";
          break;

        case "inhalation":
          iconPath = "assets/icons/inhalation.svg";
          break;

        case "subcutaneous":
          iconPath = "assets/icons/subcutaneous.svg";
          break;
      }
    }
  }

  String get totalString {
    if (total == null) return 'No data';
    return total!.dataToString;
  }

  String get comeupString {
    if (comeup == null) return 'No data';
    return comeup!.dataToString;
  }

  String get onsetString {
    if (onset == null) return 'No data';
    return onset!.dataToString;
  }

  String get offsetString {
    if (offset == null) return 'No data';
    return offset!.dataToString;
  }

  String get peakString {
    if (peak == null) return 'No data';
    return peak!.dataToString;
  }

  String get afterglowString {
    if (afterglow == null) return 'No data';
    return afterglow!.dataToString;
  }

  Map<String, dynamic> toJson() => _$PsychoROAToJson(this);
}
