import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 6) digits = digits.substring(0, 6);

    StringBuffer buffer = StringBuffer();
    int selectionIndex = newValue.selection.end;

    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write(':');
        if (i < selectionIndex) selectionIndex++;
      }
      buffer.write(digits[i]);
    }

    // تصحيح الساعات والدقائق والثواني
    if (digits.length >= 2) {
      int hour = int.tryParse(digits.substring(0, 2)) ?? 0;
      if (hour > 23) {
        digits = digits.replaceRange(0, 2, '23');
      }
    }

    if (digits.length >= 4) {
      int minute = int.tryParse(digits.substring(2, 4)) ?? 0;
      if (minute > 59) {
        digits = digits.replaceRange(2, 4, '59');
      }
    }

    if (digits.length == 6) {
      int second = int.tryParse(digits.substring(4, 6)) ?? 0;
      if (second > 59) {
        digits = digits.replaceRange(4, 6, '59');
      }
    }

    // إعادة بناء النص مع التصحيح
    buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) buffer.write(':');
      buffer.write(digits[i]);
    }

    selectionIndex = buffer.length;

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
