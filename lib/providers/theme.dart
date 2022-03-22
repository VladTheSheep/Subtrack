import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imperium/utils/themes.dart';

final themeProvider = StateProvider((ref) => Themes().getTheme());
