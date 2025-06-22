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
      if (i == 2 || i == 4) {
        buffer.write('/');
        if (i < selectionIndex) selectionIndex++;
      }
      buffer.write(digits[i]);
    }

    // تأكيد على اليوم <= 31، الشهر <= 12
    final parts = buffer.toString().split('/');
    if (parts.length >= 1 && parts[0].length == 2) {
      int day = int.tryParse(parts[0]) ?? 0;
      if (day > 31) {
        buffer.clear();
        buffer.write('31');
        if (parts.length >= 2) buffer.write('/${parts[1]}');
        if (parts.length == 3) buffer.write('/${parts[2]}');
        selectionIndex = buffer.length;
      }
    }
    if (parts.length >= 2 && parts[1].length == 2) {
      int month = int.tryParse(parts[1]) ?? 0;
      if (month > 12) {
        buffer.clear();
        buffer.write('${parts[0]}/12');
        if (parts.length == 3) buffer.write('/${parts[2]}');
        selectionIndex = buffer.length;
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
