import 'package:hive/hive.dart';
import 'package:imperium/scraping/models/data/psycho_duration_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'psycho_duration.g.dart';

@JsonSerializable()
@HiveType(typeId: 21)
class PsychoDuration {
  PsychoDuration({
    this.total,
    this.onset,
    this.comeup,
    this.peak,
    this.offset,
    this.afterglow,
  });

  factory PsychoDuration.fromJson(Map<String, dynamic> json) => _$PsychoDurationFromJson(json);

  @HiveField(0)
  PsychoDurationData? total;
  @HiveField(1)
  PsychoDurationData? onset;
  @HiveField(2)
  PsychoDurationData? comeup;
  @HiveField(3)
  PsychoDurationData? peak;
  @HiveField(4)
  PsychoDurationData? offset;
  @HiveField(5)
  PsychoDurationData? afterglow;

  Map<String, dynamic> toJson() => _$PsychoDurationToJson(this);

  String get totalToString {
    String text = '';
    if (total == null) {
      text = "No data";
    } else {
      text += '${total != null && total!.min != null ? total!.min!.floor().toString() : 'n/a'} - ';
      text += '${total != null && total!.max != null ? total!.max!.floor().toString() : 'n/a'} ';
      text += total != null ? total!.unit ?? ' n/a' : '';
    }
    return text;
  }

  String get onsetToString {
    String text = '';
    if (onset == null || onset != null && onset!.max == null && onset!.min == null) {
      text = "No data";
    } else {
      text += '${onset != null && onset!.min != null ? onset!.min!.floor().toString() : 'n/a'} - ';
      text += '${onset != null && onset!.max != null ? onset!.max!.floor().toString() : 'n/a'} ';
      text += onset != null ? onset!.unit ?? ' n/a' : '';
    }
    return text;
  }

  String get comeupToString {
    String text = '';
    if (comeup == null || comeup != null && comeup!.max == null && comeup!.min == null) {
      text = "No data";
    } else {
      text += '${comeup != null && comeup!.min != null ? comeup!.min!.floor().toString() : 'n/a'} - ';
      text += '${comeup != null && comeup!.max != null ? comeup!.max!.floor().toString() : 'n/a'} ';
      text += comeup != null ? comeup!.unit ?? ' n/a' : '';
    }
    return text;
  }

  String get peakToString {
    String text = '';
    if (peak == null || peak != null && peak!.max == null && peak!.min == null) {
      text = "No data";
    } else {
      text += '${peak != null && peak!.min != null ? peak!.min!.floor().toString() : 'n/a'} - ';
      text += '${peak != null && peak!.max != null ? peak!.max!.floor().toString() : 'n/a'} ';
      text += peak != null ? peak!.unit ?? ' n/a' : '';
    }

    return text;
  }

  String get offsetToString {
    String text = '';
    if (offset == null || offset != null && offset!.max == null && offset!.min == null) {
      text = "No data";
    } else {
      text += '${offset != null && offset!.min != null ? offset!.min!.floor().toString() : 'n/a'} - ';
      text += '${offset != null && offset!.max != null ? offset!.max!.floor().toString() : 'n/a'} ';
      text += offset != null ? offset!.unit ?? ' n/a' : '';
    }
    return text;
  }

  String get afterglowToString {
    String text = '';
    if (afterglow == null || afterglow != null && afterglow!.max == null && afterglow!.min == null) {
      text = "No data";
    } else {
      text += '${afterglow != null && afterglow!.min != null ? afterglow!.min!.floor().toString() : 'n/a'} - ';
      text += '${afterglow != null && afterglow!.max != null ? afterglow!.max!.floor().toString() : 'n/a'} ';
      text += afterglow != null ? afterglow!.unit ?? ' n/a' : '';
    }
    return text;
  }
}
