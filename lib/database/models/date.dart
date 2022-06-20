import 'package:date_utils/date_utils.dart';
import 'package:hive/hive.dart';
import 'package:subtrack/utils/settings.dart';
import 'package:subtrack/utils/string_manipulation.dart';

part 'date.g.dart';

const int startYear = 1800;
const int endYear = 3000;

@HiveType(typeId: 7)
class Date {
  Date({
    this.day = -1,
    this.month = -1,
    this.year = -1,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
  });

  factory Date.fromJson(Map<String, dynamic>? json) {
    // if (json == null) return null;
    return Date(
      day: json?["day"] as int? ?? -1,
      month: json?["month"] as int? ?? -1,
      year: json?["year"] as int? ?? -1,
      hour: json?["hour"] as int? ?? 0,
      minute: json?["minute"] as int? ?? 0,
      second: json?["second"] as int? ?? 0,
    );
  }

  factory Date.fromString(String? input) {
    final Date date = Date();
    try {
      String searchPattern = '/';

      while (true) {
        if (input == "") break;
        if (date.day != -1 && date.month != -1 && date.year == -1) {
          searchPattern = ' ';
        } else if (date.day != -1 && date.month != -1 && date.year != -1 && date.hour == 0) {
          searchPattern = ':';
        }

        int val;
        final int index = findCharPos(input, searchPattern);

        val = int.parse(input!.substring(0, index != -1 ? index : input.length));
        if (index != -1) {
          input = input.substring(index + 1);
        } else {
          input = "";
        }

        if (date.day == -1) {
          date.day = val;
        } else if (date.day != -1 && date.month == -1) {
          date.month = val;
        } else if (date.day != -1 && date.month != -1 && date.year == -1) {
          date.year = val;
        } else if (date.day != -1 && date.month != -1 && date.year != -1 && date.hour == 0) {
          date.hour = val;

          if (input.contains(':')) {
            final int charPos = findCharPos(input, ':');
            date.minute = int.parse(input.substring(0, charPos));
            date.second = int.parse(input.substring(charPos + 1));
          } else {
            date.minute = int.parse(input);
            date.second = 0;
          }
          break;
        }
      }

      return date;
    } catch (e) {
//      print('ERROR!! Date::parseString: Invalid input \'' + (input == null || input.length == 0 ? 'null' : input) + '\'. Setting to \'1/1/1970\'');
//      print(e.toString());
      final Date minDate = getMinDate();
      date.day = minDate.day;
      date.month = minDate.month;
      date.year = minDate.year;
      date.hour = minDate.hour;
      date.minute = minDate.minute;
      date.second = minDate.second;
      return minDate;
    }
  }
  factory Date.fromDate(Date input) => Date(
        day: input.day,
        month: input.month,
        year: input.year,
        hour: input.hour,
        minute: input.minute,
        second: input.second,
      );
  factory Date.fromDateTime(DateTime input) => Date(
        day: input.day,
        month: input.month,
        year: input.year,
        hour: input.hour,
        minute: input.minute,
        second: input.second,
      );

  @HiveField(0)
  int day;
  @HiveField(1)
  int month;
  @HiveField(2)
  int year;
  @HiveField(3)
  int hour;
  @HiveField(4)
  int minute;
  @HiveField(5)
  int second;

  Map<String, dynamic> toJson() => {
        "day": day,
        "month": month,
        "year": year,
        "hour": hour,
        "minute": minute,
        "second": second,
      };

  @override
  bool operator ==(Object other) {
    if (other is Date) {
      return day == other.day && month == other.month && year == other.year;
    } else {
      print('ERROR!! Date::==: Attempted to compare non-date object!');
      return false;
    }
  }

  @override
  int get hashCode => day.hashCode ^ month.hashCode ^ year.hashCode ^ hour.hashCode ^ minute.hashCode ^ second.hashCode;

  int operator >(Date date) {
    try {
      if (year < date.year) {
        return 1;
      } else if (year > date.year) {
        return -1;
      } else {
        if (month < date.month) {
          return 1;
        } else if (month > date.month) {
          return -1;
        } else {
          if (day < date.day) {
            return 1;
          } else if (day > date.day) {
            return -1;
          } else {
            if (hour < date.hour) {
              return 1;
            } else if (hour > date.hour) {
              return -1;
            } else {
              if (minute < date.minute) {
                return 1;
              } else if (minute > date.minute) {
                return -1;
              } else {
                if (second <= date.second) {
                  return 1;
                } else if (second >= date.second) {
                  return -1;
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print('ERROR Date::operator>: $e');
    }

    return -1;
  }

  int get getWeekday => DateTime(year, month, day).weekday;

  String getDateAsString({required bool fromUI, bool withSpaces = false}) {
    String result = '';
    if (Settings().data.useAltDateFormat && fromUI) {
      if (withSpaces) {
        result = '$month / $day / $year';
      } else {
        result = '$month/$day/$year';
      }
    } else {
      if (withSpaces) {
        result = '$day / $month / $year';
      } else {
        result = '$day/$month/$year';
      }
    }
    return result;
  }

  String getTimeAsString({bool noSeconds = false, required bool fromUI}) {
    String _hour = hour < 10 ? '0$hour' : hour.toString();
    final String _minute = minute < 10 ? '0$minute' : minute.toString();
    final String? _second = !noSeconds ? (second < 10 ? '0$second' : second.toString()) : null;

    String? amPm;
    if (!Settings().data.use24hourTime && fromUI) {
      int? tempHour = hour;
      if (hour > 12) {
        tempHour = hour - 12;
      } else if (hour == 0) {
        tempHour = 12;
      }

      amPm = hour >= 12 ? "PM" : "AM";

      _hour = tempHour < 10 ? '0$tempHour' : tempHour.toString();
    }

    return '$_hour:$_minute${_second != null ? ':$_second' : ''}${amPm != null ? " $amPm" : ""}';
  }

  String getDateTimeAsString({bool noSeconds = false, required bool fromUI}) =>
      '${getDateAsString(fromUI: fromUI)} ${getTimeAsString(noSeconds: noSeconds, fromUI: fromUI)}';

  DateTime get getAsDateTime => DateTime(year, month, day, hour, minute, second);

  void incrementDay() {
    ++day;
    if (day > Date.daysInMonth(year: year, month: month)) {
      incrementMonth();
      day = 1;
    }
  }

  void decrementDay() {
    --day;
    if (day < 1) {
      decrementMonth();
      day = Date.daysInMonth(year: year, month: month);
    }
  }

  void incrementMonth() {
    ++month;
    if (month > 12) {
      ++year;
      month = 1;
    }
  }

  void decrementMonth() {
    --month;
    if (month < 1) {
      --year;
      month = 12;
    }
  }

  void incrementHour() {
    ++hour;
    if (hour >= 24) {
      incrementDay();
      hour = 0;
    }
  }

  void incrementMinute() {
    ++minute;
    if (minute >= 60) {
      incrementHour();
      minute = 1;
    }
  }

  void incrementSecond() {
    ++second;
    if (second >= 60) {
      incrementMinute();
      second = 1;
    }
  }

  void dateTimeToDate(DateTime dateTime) {
    year = dateTime.year;
    month = dateTime.month;
    day = dateTime.day;
    hour = dateTime.hour;
    minute = dateTime.minute;
  }

  void parseString(String input) {
    try {
      String searchPattern = '/';
      String str = input;

      while (true) {
        if (day != -1 && month != -1 && year == -1) {
          searchPattern = ' ';
        } else if (day != -1 && month != -1 && year != -1 && hour == 0) {
          searchPattern = ':';
        }

        final int index = findCharPos(str, searchPattern);
        final int val = int.parse(str.substring(0, index));
        str = str.substring(index + 1);

        if (day == -1) {
          day = val;
        } else if (day != -1 && month == -1) {
          month = val;
        } else if (day != -1 && month != -1 && year == -1) {
          year = val;
        } else if (day != -1 && month != -1 && year != -1 && hour == 0) {
          hour = val;

          if (str.contains(':')) {
            final int charPos = findCharPos(str, ':');
            minute = int.parse(str.substring(0, charPos));
            second = int.parse(str.substring(charPos + 1));
          } else {
            minute = int.parse(str);
            second = 0;
          }
          break;
        }
      }
    } catch (e) {
//      print('ERROR!! Date::parseString: Invalid input \'' + (input == null || input.length == 0 ? 'null' : input) + '\'. Setting to \'1/1/1970\'');
//      print(e.toString());
      final Date minDate = getMinDate();
      day = minDate.day;
      month = minDate.month;
      year = minDate.year;
      hour = minDate.hour;
      minute = minDate.minute;
      second = minDate.second;
    }
  }

  static int daysInMonth({int? month, int? year}) {
    DateTime firstOfNextMonth;
    if (month == 12) {
      firstOfNextMonth = DateTime(year! + 1, 1, 1, 12);
    } else {
      firstOfNextMonth = DateTime(year!, month! + 1, 1, 12);
    }

    final int temp = firstOfNextMonth.subtract(const Duration(days: 1)).day;
    return temp;
  }

  static int toSeconds(Date date) {
    int totalSeconds = 0;

    if (date.year > 0) totalSeconds += date.year * 365 * 24 * 60 * 60;
    if (date.month > 0) {
      int monthCount = date.month;
      while (monthCount > 0) {
        totalSeconds += daysInMonth(month: monthCount, year: getNow().year) * 24 * 60 * 60;
        monthCount--;
      }
    }
    if (date.day > 0) totalSeconds += date.day * 24 * 60 * 60;
    if (date.hour > 0) totalSeconds += date.hour * 60 * 60;
    if (date.minute > 0) totalSeconds += date.minute * 60;

    return totalSeconds + date.second;
  }
}

String weekdayToDay(int input, {bool abbreviate = false}) {
  switch (input) {
    case 1:
      return abbreviate ? 'Mon' : 'Monday';

    case 2:
      return abbreviate ? 'Tue' : 'Tuesday';

    case 3:
      return abbreviate ? 'Wed' : 'Wednesday';

    case 4:
      return abbreviate ? 'Thu' : 'Thursday';

    case 5:
      return abbreviate ? 'Fri' : 'Friday';

    case 6:
      return abbreviate ? 'Sat' : 'Saturday';

    case 7:
      return abbreviate ? 'Sun' : 'Sunday';

    default:
      print('ERROR!! Date::weekdayToDay: Invalid input -- $input (must be in range 1..7)');
      return 'Error!';
  }
}

int dayToWeekday(String input) {
  final String _input = input.toLowerCase();
  switch (_input) {
    case 'mon':
    case 'monday':
      return 1;

    case 'tue':
    case 'tuesday':
      return 2;

    case 'wed':
    case 'wednesday':
      return 3;

    case 'thu':
    case 'thursday':
      return 4;

    case 'fri':
    case 'friday':
      return 5;

    case 'sat':
    case 'saturday':
      return 6;

    case 'sun':
    case 'sunday':
      return 7;

    default:
      return 0;
  }
}

String monthToString(int month, {bool abbreviate = false}) {
  switch (month) {
    case 1:
      return abbreviate ? 'Jan' : 'January';

    case 2:
      return abbreviate ? 'Feb' : 'February';

    case 3:
      return abbreviate ? 'Mar' : 'March';

    case 4:
      return abbreviate ? 'Apr' : 'April';

    case 5:
      return abbreviate ? 'May' : 'May';

    case 6:
      return abbreviate ? 'Jun' : 'June';

    case 7:
      return abbreviate ? 'Jul' : 'July';

    case 8:
      return abbreviate ? 'Aug' : 'August';

    case 9:
      return abbreviate ? 'Sep' : 'September';

    case 10:
      return abbreviate ? 'Oct' : 'October';

    case 11:
      return abbreviate ? 'Nov' : 'November';

    case 12:
      return abbreviate ? 'Dec' : 'December';

    default:
      throw 'ERROR!! Date::monthToString: Unknown month int as input! -- $month';
  }
}

String abbreviationToFull(String month) {
  switch (month.toLowerCase()) {
    case 'jan':
      return 'January';

    case 'feb':
      return 'February';

    case 'mar':
      return 'March';

    case 'apr':
      return 'April';

    case 'may':
      return 'May';

    case 'jun':
      return 'June';

    case 'jul':
      return 'July';

    case 'aug':
      return 'August';

    case 'sep':
      return 'September';

    case 'oct':
      return 'October';

    case 'nov':
      return 'November';

    case 'dec':
      return 'December';

    default:
      print('ERROR!! Date::abbreviationToFull: Invalid input! -- $month');
      return 'INVALID INPUT';
  }
}

bool isBeforeDate(Date d1, Date d2) {
  try {
    if (d1.year < d2.year) {
      return true;
    } else if (d1.year > d2.year) {
      return false;
    } else {
      if (d1.month < d2.month) {
        return true;
      } else if (d1.month > d2.month) {
        return false;
      } else {
        if (d1.day < d2.day) {
          return true;
        } else if (d1.day > d2.day) {
          return false;
        } else {
          if (d1.hour < d2.hour) {
            return true;
          } else if (d1.hour > d2.hour) {
            return false;
          } else {
            if (d1.minute < d2.minute) {
              return true;
            } else if (d1.minute > d2.minute) {
              return false;
            } else {
              if (d1.second <= d2.second) {
                return true;
              } else if (d1.second >= d2.second) {
                return false;
              }
            }
          }
        }
      }
    }
  } catch (e) {
    print('ERROR!! Date::isBeforeDate: $e');
  }

  return false;
}

String dateToString(Date date) {
  return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}:${date.second}';
}

Date getNow() {
  final DateTime now = DateTime.now();
  return Date(day: now.day, month: now.month, year: now.year, hour: now.hour, minute: now.minute, second: now.second);
}

Date getMinDate() {
  final DateTime min = DateTime(1970);
  return Date(day: min.day, month: min.month, year: min.year, hour: min.hour, minute: min.minute, second: min.second);
}

Date? calculateDateDifference(Date? start, Date? end, {bool checkSeconds = false}) {
  if (start == null ||
      end == null ||
      start.day == -1 && start.month == -1 && start.year == -1 && start.hour == -1 && start.minute == -1 && start.second == -1 ||
      end.day == -1 && end.month == -1 && end.year == -1 && end.hour == -1 && end.minute == -1 && end.second == -1) return null;

  Date _start;
  Date _end;

  if (!isBeforeDate(start, end)) {
    _start = Date.fromDate(end);
    _end = Date.fromDate(start);
  } else {
    _start = Date.fromDate(start);
    _end = Date.fromDate(end);
  }

  final DateTime startDate = DateTime(_start.year, _start.month, _start.day, _start.hour, _start.minute, _start.second);
  final DateTime endDate = DateTime(_end.year, _end.month, _end.day, _end.hour, _end.minute, _end.second);

  int year = startDate.year;
  int month = startDate.month;
  int day = startDate.day;
  int hour = startDate.hour;
  int minute = startDate.minute;
  int second = startDate.second;

  if (startDate.difference(endDate).inDays.abs() >= 0) {
    year = endDate.year - startDate.year;

    if ((month = endDate.month - startDate.month) < 0) {
      --year;
      month += 12;
    }

    if ((day = endDate.day - startDate.day) < 0) {
      if (--month < 0) {
        --year;
        month += 12;
      }

      day += DateUtils.lastDayOfMonth(startDate).day;
    }

    if ((hour = endDate.hour - startDate.hour) < 0) {
      if (--day < 0) {
        if (--month < 0) {
          --year;
          month += 12;
        }

        day += DateUtils.lastDayOfMonth(startDate).day;
      }

      hour += 24;
    }

    if ((minute = endDate.minute - startDate.minute) < 0) {
      if (--hour < 0) {
        if (--day < 0) {
          if (--month < 0) {
            --year;
            month += 12;
          }

          day += DateUtils.lastDayOfMonth(startDate).day;
        }

        hour += 24;
      }

      minute += 60;
    }

    if (checkSeconds && (second = endDate.second - startDate.second) < 0) {
      if (--minute < 0) {
        if (--hour < 0) {
          if (--day < 0) {
            if (--month < 0) {
              --year;
              month += 12;
            }

            day += DateUtils.lastDayOfMonth(startDate).day;
          }

          hour += 24;
        }

        minute += 60;
      }

      second += 60;
    }
  }

  return Date(year: year, month: month, day: day, hour: hour, minute: minute, second: second);
}

int getNumberOfDaysSince(Date start, Date end) {
  int days = 0;
  final Date temp = Date.fromDate(start);

  if (temp.month >= end.month && temp.year >= end.year) {
    return days += end.day - start.day;
  }

  if (temp.year <= end.year) {
    days += Date.daysInMonth(month: temp.month, year: temp.year) - temp.day;
    temp.incrementMonth();
  }

  while (true) {
    if (temp.month >= end.month && temp.year >= end.year) {
      days += end.day;
      break;
    } else {
      days += Date.daysInMonth(month: temp.month, year: temp.year);
      temp.incrementMonth();
    }
  }
  return days;
}

String getDateDifference(Date start, Date end, {bool noPrefixSuffix = false}) {
  bool inFuture = false;
  if (!isBeforeDate(start, end)) inFuture = true;

  return getTimeSince(calculateDateDifference(start, end)!, inFuture: inFuture, noPrefixSuffix: noPrefixSuffix);
}

String getTimeSince(Date timeDiff, {bool inFuture = false, bool noPrefixSuffix = false}) {
  String timeSince = noPrefixSuffix
      ? ''
      : inFuture
          ? 'In '
          : '';
  final String endString = noPrefixSuffix
      ? ''
      : inFuture
          ? ''
          : 'ago';

  if (timeDiff.year > 0) {
    timeSince += timeDiff.year.toString() +
        (timeDiff.year > 1 ? ' years ' : ' year ') +
        (timeDiff.month > 0 ? 'and ${timeDiff.month}${timeDiff.month > 1 ? ' months ' : ' month '}$endString' : endString);
  } else if (timeDiff.month > 0) {
    timeSince += timeDiff.month.toString() +
        (timeDiff.month > 1 ? " months " : " month ") +
        (timeDiff.day > 0 ? "and ${timeDiff.day}${timeDiff.day > 1 ? " days " : " day "}$endString" : endString);
  } else if (timeDiff.day > 0) {
    timeSince += timeDiff.day.toString() +
        (timeDiff.day > 1 ? " days " : " day ") +
        (timeDiff.hour > 0 ? "and ${timeDiff.hour}${timeDiff.hour > 1 ? " hours " : " hour "}$endString" : endString);
  } else if (timeDiff.hour > 0) {
    timeSince += timeDiff.hour.toString() +
        (timeDiff.hour > 1 ? " hours " : " hour ") +
        (timeDiff.minute > 0 ? "and ${timeDiff.minute}${timeDiff.minute > 1 ? " minutes " : " minute "}$endString" : endString);
  } else if (timeDiff.minute > 0) {
    timeSince += timeDiff.minute.toString() + (timeDiff.minute > 1 ? " minutes " : " minute ") + endString;
  } else {
    timeSince = '';
  }

  if (timeSince.isEmpty) timeSince = "Just now";

  return timeSince;
}

bool isSameDate(Date a, Date b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool isSameMonth(Date a, Date b) {
  return a.year == b.year && a.month == b.month;
}
