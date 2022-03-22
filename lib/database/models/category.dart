import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imperium/utils/string_manipulation.dart';

part 'category.g.dart';

@HiveType(typeId: 25)
class Category extends HiveObject {
  Category({this.name, this.description, this.wiki, this.tips});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"] as String?,
        description: json["description"] as String?,
        wiki: json["wiki"] as String?,
        tips: json["tips"] as List<dynamic>?,
      );

  @HiveField(0)
  String? name = '';
  @HiveField(1)
  String? description = '';
  @HiveField(2)
  @HiveField(3)
  String? iconPath = 'assets/icons/unknown.svg';
  @HiveField(4)
  bool? misc = false;
  @HiveField(5)
  bool? selected = false;
  @HiveField(6)
  List<dynamic>? tips = [];
  @HiveField(7)
  String? wiki = '';
  // @HiveField(8)
  @HiveField(9)
  int _color = Colors.grey.value;

  Color get color => Color(_color);
  set color(Color color) => _color = color.value;

  String get getPrettyName {
    String result = '';
    for (int i = 0; i < name!.length; ++i) {
      if (name![i] != '-') {
        result += name![i];
      } else {
        result += ' ';
      }
    }

    return firstCharUppercase(result);
  }

  // static void openCategoryInfo(BuildContext context, Category category) {
  //   final List<Paragraph> paragraphs = [
  //     Paragraph(
  //       content: category.description != null && category.description!.isNotEmpty ? category.description : 'No description exists for this category.',
  //     )
  //   ];

  //   Nav.openDialog(
  //     AlertPrompt(
  //       title: category.getPrettyName,
  //       paragraphs: paragraphs,
  //       leftBtnLabel: '',
  //       rightBtnLabel: '',
  //       boolCallback: true,
  //       icon: SubstanceManager.getCategoryIcon(category, noClick: true, iconSize: 28.0),
  //       btnHeight: 35.0,
  //     ),
  //     dismissible: true,
  //   );
  // }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "wikiLink": wiki,
        "tips": tips,
      };
}
