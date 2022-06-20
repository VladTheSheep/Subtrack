import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/utils/string_manipulation.dart';

part 'psycho_duration_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 22)
class PsychoDurationData {
  PsychoDurationData({this.min, this.max, this.unit});
  factory PsychoDurationData.fromJson(Map<String, dynamic> json) => _$PsychoDurationDataFromJson(json);

  factory PsychoDurationData.stringToDoseInfo(String input) {
    final PsychoDurationData result = PsychoDurationData();
    final String noDigits = removeAllChars(input, skipSymbols: true);
    if (noDigits.isNotEmpty) {
      int index = findCharPos(input, '-', false);
      if (index != -1) {
        final String tempLow = input.substring(0, index);
        final int lowIndex = findChar(tempLow);
        result.min = double.parse(input.substring(0, lowIndex != -1 ? lowIndex : index));
        input = input.substring(index + 1);
        index = -1;

        final int doseIndex = findCharNoSymbol(input);

        if (doseIndex > 1) {
          result.max = double.parse(input.substring(0, doseIndex));
        } else if (doseIndex == -1) {
          result.max = double.parse(input);
        }
      } else {
        index = findChar(input);

        if (index != -1) {
          final String first = input.substring(0, index);
          final String last = input.substring(index);
          final int i = findChar(first);
          if (i == -1 && first.isNotEmpty) {
            if (last.contains('+')) {
              result.max = double.tryParse(input.substring(0, index));
            } else {
              result.min = double.parse(removeAllChars(first));
            }
          }
        }
      }
    }

    return result;
  }

  @HiveField(0)
  double? min;
  @HiveField(1)
  double? max;
  @HiveField(2)
  String? unit;
  // @HiveField(3)
  // List<String>? roa = [];

  Map<String, dynamic> toJson() => _$PsychoDurationDataToJson(this);

  String get dataToString {
    String text = '';
    text += '${min != null ? min!.floor().toString() : 'n/a'} - ';
    text += '${max != null ? max!.floor().toString() : 'n/a'} ';
    text += unit ?? ' n/a';

    if (min == null && max == null && unit == null) return 'No data';

    return text;
  }
}
