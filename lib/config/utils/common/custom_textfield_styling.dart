import 'package:flutter/material.dart';

class CustomStyling {
  /// Returns a customized input decoration for text fields.
  static InputDecoration customInputDecorationStyling({
    required bool enable,
    required String hintText,
    required TextStyle hintTextStyle,
    double? radius,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color? insideColor,
    Color? enableBorderColor,
    Color? errorBorderColor,
    Color? focusedColor,
    String? errorText,
    bool removeUnderline = false,
  }) {
    return InputDecoration(
      fillColor: insideColor ?? Colors.white,
      filled: true,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabled: enable,
      hintText: hintText,
      hintStyle: hintTextStyle,
      enabledBorder: removeUnderline
          ? InputBorder.none
          : OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide(
          color: enableBorderColor ?? Colors.grey,
          width: 1,
        ),
      ),
      disabledBorder: removeUnderline
          ? InputBorder.none
          : OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedBorder: removeUnderline
          ? InputBorder.none
          : OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide(
          color: focusedColor ?? Colors.white,
          width: 1.6,
        ),
      ),
      border: removeUnderline
          ? InputBorder.none
          : OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide(
          color: errorBorderColor ?? Colors.red,
          width: 1,
        ),
      ),
      errorText: errorText,
    );
  }
}
