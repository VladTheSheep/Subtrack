import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/utils/string_manipulation.dart';

part 'psycho_dose_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 20)
class PsychoDoseData {
  PsychoDoseData({this.min, this.max});

  factory PsychoDoseData.fromJson(Map<String, dynamic> json) => _$PsychoDoseDataFromJson(json);

  factory PsychoDoseData.stringToDoseInfo(String input, String type) {
    final PsychoDoseData result = PsychoDoseData();
    final String noDigits = removeAllChars(input, skipSymbols: true);
    if (noDigits.isNotEmpty) {
      int index = findCharPos(input, '-', false);
      if (index != -1) {
        final String tempLow = input.substring(0, index);
        final int lowIndex = findChar(tempLow);
        result.min = double.parse(input.substring(0, lowIndex != -1 ? lowIndex : index));
        input = input.substring(index + 1);
        index = -1;

        int doseIndex = findCharWithDot(input);

        if (doseIndex > 0 && type.toLowerCase() != "threshold" && type.toLowerCase() != "heavy") {
          result.max = double.parse(input.substring(0, doseIndex));
          input = input.substring(doseIndex);
          doseIndex = findCharNoSymbol(input);
        } else if (doseIndex == -1 && type.toLowerCase() != "threshold" && type.toLowerCase() != "heavy") {
          result.max = double.parse(input);
        }
      } else {
        index = findChar(input);

        if (index != -1) {
          final String first = input.substring(0, index);
          final String last = input.substring(index);
          final int i = findChar(first);
          if (i == -1 && first.isNotEmpty) {
            final int index = findDigitNoSymbols(last);
            if (last.contains('+') && type.toLowerCase() != "threshold" && type.toLowerCase() != "heavy" && index != -1) {
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

  Map<String, dynamic> toJson() => _$PsychoDoseDataToJson(this);
}
