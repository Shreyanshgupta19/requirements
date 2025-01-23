import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat('dd-MM-yyyy');
final timeFormatter = DateFormat('HH:mm:ss');
final timeDateAbrFormatter = DateFormat('HH:mm:ss dd-MMM-yyyy');
final dateTimeFormatter = DateFormat('HH:mm:ss dd-MM-yy');
final dateTimeFormatterWithMs = DateFormat('HH:mm:ss.SS dd-MM-yy');
const emptyDateTimeString = "-";

class Format {
  static String date(int? epoch) {
    if (epoch == null) return "-";
    final dt = DateTime.fromMillisecondsSinceEpoch(epoch);
    return dateFormatter.format(dt);
  }

  static String time(int? epoch) {
    if (epoch == null) return emptyDateTimeString;
    final dt = DateTime.fromMillisecondsSinceEpoch(epoch);
    return timeFormatter.format(dt);
  }

  static String dateTime(int? epoch) {
    if (epoch == null) return emptyDateTimeString;
    final dt = DateTime.fromMillisecondsSinceEpoch(epoch);
    return dateTimeFormatter.format(dt);
  }

  static String dateTimeWithMilliSec(int? epoch) {
    if (epoch == null) return emptyDateTimeString;
    final dt = DateTime.fromMillisecondsSinceEpoch(epoch);
    return dateTimeFormatterWithMs.format(dt);
  }

  static String dateTimeObject(DateTime? dtObject, {bool toLocal = true}) {
    if (toLocal) dtObject = dtObject?.toLocal();
    return dtObject != null
        ? dateTimeFormatter.format(dtObject)
        : emptyDateTimeString;
  }

  static String timeObject(DateTime? dtObject, {bool toLocal = true}) {
    if (toLocal) dtObject = dtObject?.toLocal();
    return dtObject != null
        ? timeFormatter.format(dtObject)
        : emptyDateTimeString;
  }

  static String timeDateAbrObject(DateTime? dtObject, {bool toLocal = true}) {
    if (toLocal) dtObject = dtObject?.toLocal();
    return dtObject != null
        ? timeDateAbrFormatter.format(dtObject)
        : emptyDateTimeString;
  }

  static String dateObject(DateTime? dtObject, {bool toLocal = true}) {
    if (toLocal) dtObject = dtObject?.toLocal();
    return dtObject != null
        ? dateFormatter.format(dtObject)
        : emptyDateTimeString;
  }

  static String duration(DateTime? smallTime, DateTime? bigTime) {
    if (smallTime == null || bigTime == null) return '-';
    final durationGap = bigTime.difference(smallTime);
    if (durationGap.inMinutes == 0) {
      return '${durationGap.inSeconds} sec';
    } else if (durationGap.inHours == 0) {
      return '${durationGap.inMinutes} min';
    } else if (durationGap.inDays == 0) {
      return '${durationGap.inHours} hr ${durationGap.inMinutes % 60} min';
    } else {
      return '${durationGap.inDays} day ${durationGap.inHours % 24} hr';
    }
  }

  static String _capitaliseUtil(String s) {
    if (s.isNotEmpty) {
      String newString = s[0].toUpperCase() + s.substring(1).toLowerCase();
      return newString;
    }
    return s;
  }

  static String spaceJoin(String val, String sep) {
    return val.split(sep).join(" ");
  }

  static String truncateString(String val, int maxLength) {
    if (val.length > maxLength) {
      return '${val.substring(0, maxLength - 2)}..';
    }
    return val;
  }

  static String capitalise(String val) {
    final arr = val.split(" ");
    for (int i = 0; i < arr.length; i++) {
      arr[i] = Format._capitaliseUtil(arr[i]);
    }
    return arr.join(" ");
  }

  static String shortAssetName(String val) {
    if (val.split("_").length > 3) {
      return val.split("_").sublist(3).join("_");
    }
    return val;
  }

  static String shortAssetNameWithStation(String val) {
    if (val.split("_").length > 3) {
      final tmp = val.split("_");
      return "${tmp[2]}-${tmp.sublist(3).join("_")}";
    }
    return val;
  }

  static String fromValue(dynamic val) {
    if (val == null) return "-";
    return val.toString();
  }

  static Color fixedColor(String str) {
    int hash = 0;
    for (int i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }

    String colour = "";
    for (int i = 0; i < 3; i++) {
      int value = (hash >> (i * 8)) & 0xff;
      String stringVal = "00$value";
      colour += stringVal.substring(stringVal.length - 2);
    }
    return Color(int.parse(colour)).withOpacity(1);
  }

  static String fromDouble(double? val) {
    return val?.toStringAsFixed(2) ?? '-';
  }

  static String shortenFileName(String name, {int? pref, int? suff}) {
    pref = 4;
    suff = 5;
    if (name.length <= pref + suff) return name;
    String prefString = name.substring(0, pref);
    String suffString = name.substring(name.length - suff);
    return "$prefString...$suffString";
  }

  static String shortenLabel(String label, {int n = 5}) {
    if (label.length <= n) return label;
    if (n < 2) n = 2;
    return "${label.substring(0, min(label.length, n - 1))}..";
  }
}
