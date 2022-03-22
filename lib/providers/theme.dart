import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subtrack/utils/themes.dart';

final themeProvider = StateProvider((ref) => Themes().getTheme());
