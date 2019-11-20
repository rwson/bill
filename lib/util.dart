import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
