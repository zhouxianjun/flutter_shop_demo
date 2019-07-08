import 'package:flutter/services.dart';

class NumberInputTextInputFormatter extends TextInputFormatter {
  final double min;
  final double max;
  final double defaultValue;
  final bool force;
  final int fractionDigits;

  NumberInputTextInputFormatter(
      {this.min = 0,
      this.max = double.infinity,
      this.defaultValue = 0,
      this.force = true,
      this.fractionDigits = 1});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String value = newValue.text;
    final double oldVal = double.tryParse(oldValue.text) ?? defaultValue;
    int selectionIndex = newValue.selection.end;
    double val = double.tryParse(value);
    if (val == null && (value == null || value.length <= 0)) {
      val = defaultValue;
    } else {
      val = val < min
          ? (force ? min : oldVal)
          : val > max ? (force ? max : oldVal) : val;
    }
    return new TextEditingValue(
      text: val.toStringAsFixed(fractionDigits),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
