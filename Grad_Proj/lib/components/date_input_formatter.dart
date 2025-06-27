import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 8) digits = digits.substring(0, 8);

    StringBuffer buffer = StringBuffer();
    int selectionIndex = newValue.selection.end;

    for (int i = 0; i < digits.length; i++) {
      if (i == 4 || i == 6) {
        buffer.write('-');
        if (i < selectionIndex) selectionIndex++;
      }
      buffer.write(digits[i]);
    }

    // تأكيد على الشهر <= 12 واليوم <= 31
    if (digits.length >= 6) {
      int month = int.tryParse(digits.substring(4, 6)) ?? 0;
      if (month > 12) {
        digits = digits.replaceRange(4, 6, '12');
        buffer = StringBuffer();
        for (int i = 0; i < digits.length; i++) {
          if (i == 4 || i == 6) buffer.write('-');
          buffer.write(digits[i]);
        }
        selectionIndex = buffer.length;
      }
    }

    if (digits.length == 8) {
      int day = int.tryParse(digits.substring(6, 8)) ?? 0;
      if (day > 31) {
        digits = digits.replaceRange(6, 8, '31');
        buffer = StringBuffer();
        for (int i = 0; i < digits.length; i++) {
          if (i == 4 || i == 6) buffer.write('-');
          buffer.write(digits[i]);
        }
        selectionIndex = buffer.length;
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
