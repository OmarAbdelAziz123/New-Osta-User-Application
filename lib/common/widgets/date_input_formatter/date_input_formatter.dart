import 'package:osta_user_app/utils/constants/exports.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length > 10) {
      /// Enforce a maximum length of 10 characters
      return oldValue;
    }

    /// Format as MM/DD/YYYY
    var newText = _applyDateFormat(text);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _applyDateFormat(String text) {
    /// Remove any characters that aren't digits or slashes
    var digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply slashes
    if (digitsOnly.length > 4) {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2, 4)}/${digitsOnly.substring(4, digitsOnly.length)}';
    } else if (digitsOnly.length > 2) {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2, digitsOnly.length)}';
    } else {
      return digitsOnly;
    }
  }
}

