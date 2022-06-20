import 'package:flutter/material.dart';
import 'package:subtrack/database/models/category.dart';
import 'package:subtrack/database/models/substance.dart';
import 'package:subtrack/managers/substance_manager.dart';

class CategoryBadge extends StatelessWidget {
  const CategoryBadge({
    Key? key,
    required this.category,
    this.extraLabels = const [],
    this.substance,
    this.size = 45.0,
    this.botSubtraction = 1.0,
    this.topShadowBlur = 1.0,
    this.botShadowBlur = 1.0,
    this.xOffset = 1.0,
    this.yOffset = 1.0,
    this.noText = false,
    this.noClick = false,
    this.inactive = false,
    this.color,
  }) : super(key: key);

  final double topShadowBlur;
  final double botShadowBlur;
  final double size;
  final double botSubtraction;
  final Category category;
  final Color? color;
  final List<String> extraLabels;
  final bool noText;
  final bool noClick;
  final bool inactive;
  final Substance? substance;
  final double xOffset;
  final double yOffset;

  @override
  Widget build(BuildContext context) {
    const double padding = 3.0;
    final List<Widget> children = [];
    final List<Widget> texts = _prepareLabels();

    final Widget _icon = SizedBox(
      width: size - botSubtraction,
      height: size - botSubtraction,
      child: Padding(
        padding: EdgeInsets.zero,
        child: SubstanceManager().getCategoryIcon(category, forceSimple: true, color: color),
      ),
    );

    final bool _noClick;
    if (inactive) {
      _noClick = true;
    } else {
      _noClick = noClick;
    }

    Widget badge;
    if (!_noClick) {
      badge = Material(
        color: Colors.transparent,
        child: SizedBox(
          width: size,
          height: size,
          child: Align(
            child: InkWell(
              customBorder: const CircleBorder(),
              // onTap: !_noClick ? () => Category.openCategoryInfo(context, category) : null,
              child: _icon,
            ),
          ),
        ),
      );
    } else {
      badge = _icon;
    }

    children.add(badge);

    if (!noText) {
      children.add(const Padding(padding: EdgeInsets.all(padding)));
      children.add(Column(children: texts));
      children.add(const Padding(padding: EdgeInsets.all(padding)));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  List<Widget> _prepareLabels() {
    final List<Widget> result = [];
    result.add(Text(category.getPrettyName, style: const TextStyle(fontSize: 12.0)));
    for (final String label in extraLabels) {
      result.add(Text(label, style: const TextStyle(fontSize: 12.0)));
    }
    return result;
  }
}
