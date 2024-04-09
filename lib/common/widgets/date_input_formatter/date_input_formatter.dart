import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length > 10) {
      /// Enforce a maximum length of 10 characters
      return oldValue;
    }

    /// Format as YYYY-MM-DD
    var newText = _applyDateFormat(text);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _applyDateFormat(String text) {
    /// Remove any characters that aren't digits
    var digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply hyphens
    if (digitsOnly.length > 6) {
      // If more than 6 digits, format as YYYY-MM-DD
      return '${digitsOnly.substring(0, 4)}-${digitsOnly.substring(4, 6)}-${digitsOnly.substring(6, digitsOnly.length)}';
    } else if (digitsOnly.length > 4) {
      // If more than 4 digits, format as YYYY-MM
      return '${digitsOnly.substring(0, 4)}-${digitsOnly.substring(4, digitsOnly.length)}';
    } else {
      // Else, just return the year part or whatever is available
      return digitsOnly;
    }
  }
}
