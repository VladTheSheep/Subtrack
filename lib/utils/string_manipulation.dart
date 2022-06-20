int findCharPos(String? string, String pattern) {
  final String _pattern = pattern[0];

  for (int i = string!.length - 1; i >= 0; --i) {
    if (_pattern == string[i]) {
      return i;
    }
  }

  return -1;
}

int findChar(String input, {bool skipSymbols = false}) {
  for (int i = 0; i < input.length; ++i) {
    final bool symbols = input[i] != '-' && input[i] != '.' && input[i] != '+';
    if (skipSymbols && int.tryParse(input[i]) == null) {
      return i;
    } else if (int.tryParse(input[i]) == null && symbols) {
      return i;
    }
  }

  return -1;
}

int findCharNoSymbol(String input) {
  for (int i = 0; i < input.length; ++i) {
    if (int.tryParse(input[i]) == null) return i;
  }

  return -1;
}

int findCharWithDot(String input) {
  for (int i = 0; i < input.length; ++i) {
    if (int.tryParse(input[i]) == null && input[i] != '.') return i;
  }

  return -1;
}

int findDigit(String input, {bool skipSymbols = false}) {
  for (int i = 0; i < input.length; ++i) {
    final bool symbols = input[i] == '-' && input[i] == '+';
    if (skipSymbols && int.tryParse(input[i]) != null) {
      return i;
    } else if (int.tryParse(input[i]) != null || symbols) {
      return i;
    }
  }

  return -1;
}

int findDigitNoSymbols(String input) {
  for (int i = 0; i < input.length; ++i) {
    if (int.tryParse(input[i]) != null) return i;
  }

  return -1;
}

String stripTrailingZero(String input) {
  final int index = findCharPos(input, '.');
  int iter = 0;

  try {
    if (index != -1) {
      String temp = input.substring(index + 1);

      while (temp.length > 1 && temp.endsWith('0')) {
        temp = temp.substring(0, temp.length - 1);
        ++iter;
      }

      if (temp.length == 1 && temp[0] == '0') iter += 2;

      return input.substring(0, input.length - iter);
    }
  } catch (e) {
    print('Error in stripTrailingZero -- $e\nOffending input: $input\nIndex: $index\nIter: $iter');
    return input;
  }

  return input;
}

String replaceCharAt(String oldString, int index, String newChar) => oldString.substring(0, index) + newChar + oldString.substring(index + 1);
String removeCharAt(int index, String input) => input.substring(0, index) + input.substring(index + 1);

String firstCharUppercase(String input) {
  if (input.length > 2) {
    return input[0].toUpperCase() + input.substring(1);
  } else if (input.length == 1) {
    return input[0].toUpperCase();
  } else {
    return input;
  }
}

String removeAllChars(String input, {bool skipSymbols = false}) {
  final StringBuffer result = StringBuffer();
  String _input = input;
  int index;

  while (true) {
    index = findDigit(_input, skipSymbols: skipSymbols);
    if (index == -1 || _input.isEmpty) break;
    result.write(_input[index]);
    _input = removeCharAt(index, _input);
  }

  return result.toString();
}

String removeCharFromString(String input) {
  String _input = input;
  int index = findChar(_input);

  while ((index = findChar(_input)) != -1) {
    _input = replaceCharAt(_input, index, '');
    index = findChar(_input);
  }

  return _input;
}

String stripPathAndExtension(String input) => input.substring(input.lastIndexOf('/') + 1, input.lastIndexOf('.'));
