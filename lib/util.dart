import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_daydart/flutter_daydart.dart';

class PrecisionLimitFormatter extends TextInputFormatter {
  int _scale;

  PrecisionLimitFormatter(this._scale);

  RegExp exp = new RegExp("[0-9.]");
  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    if (newValue.text.contains(POINTER)) {
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      int lengthAfterPointer = input.substring(index, input.length).length - 1;
      if (lengthAfterPointer > _scale) {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      return oldValue;
    }
    return newValue;
  }
}

class Util {

  static String frenquency2Weekday(String frequency) {
    List<String> frequencys = frequency.split('-');
    List<String> weekdays = new List();

    if (frequencys.length == 7) {
      return '每天';
    }

    frequencys.forEach((String item) {
      switch (item) {
        case '1':
          weekdays.add('周一');
        break;

        case '2':
          weekdays.add('周一');
        break;

        case '3':
          weekdays.add('周三');
        break;

        case '4':
          weekdays.add('周四');
        break;

        case '5':
          weekdays.add('周五');
        break;

        case '6':
          weekdays.add('周六');
        break;

        default:
          weekdays.add('周日');
        break;
      }
    });

    return weekdays.join(' ');
  }

  static bool isAfter(String time) {
    int now = int.parse(DayDart().format(fm: 'HH:mm').replaceAll(':', ''));
    int times = int.parse(time.replaceAll(':', ''));
    return now > times;
  }

}
