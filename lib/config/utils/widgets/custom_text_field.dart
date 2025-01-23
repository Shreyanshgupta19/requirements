import 'package:firebase_todo_app/config/utils/common/custom_textfield_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextFieldProperties {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardTypes;
  final int maxLines;
  final bool obscureText;
  final bool enabledSuggestions;
  void Function(dynamic value)? onChangedFunc;

  CustomTextFieldProperties({
    this.controller,
    this.validator,
    required this.keyboardTypes,
    this.obscureText = false,
    this.onChangedFunc,
    this.enabledSuggestions = false,
    required this.maxLines,
  });
}

class CustomInputTextStyle {
  final TextStyle style;

  CustomInputTextStyle({required this.style});
}

class CustomHintTextStyle {
  final TextStyle style;

  CustomHintTextStyle({required this.style});
}

class CustomSuffixIconStyle {
  final String? imageIcon;
  final IconData? icon;
  final VoidCallback? onTap;
  final double? textFieldHeight;
  final double? textFieldWidth;

  CustomSuffixIconStyle({
    this.imageIcon,
    this.icon,
    this.onTap,
    this.textFieldHeight,
    this.textFieldWidth,
  });
}

class CustomBorderStyle {
  final double radius;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  // final double borderWidth;

  CustomBorderStyle({
    this.radius = 8.0,
    this.enabledBorderColor = const Color.fromARGB(255, 239, 240, 246),
    this.disabledBorderColor = Colors.black38,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    // this.borderWidth = 1.0,
  });
}

class CustomInputDecorationStyle {
  final CustomBorderStyle borderStyle;
  final CustomSuffixIconStyle? suffixIconStyle;
  final String hintText;
  final CustomHintTextStyle hintTextStyle;

  CustomInputDecorationStyle({
    required this.borderStyle,
    this.suffixIconStyle,
    required this.hintText,
    required this.hintTextStyle,
  });

  InputDecoration  decoration(BuildContext context) {
    // InputDecoration get decoration {
    return CustomStyling.customInputDecorationStyling(
        enable: true,
        hintText: hintText,
        hintTextStyle: hintTextStyle.style,
        suffixIcon: suffixIconStyle != null
            ? GestureDetector(
          onTap: suffixIconStyle!.onTap,
          child: suffixIconStyle!.imageIcon != null
              ? Image.asset(
            suffixIconStyle!.imageIcon!,
            height: suffixIconStyle!.textFieldHeight ?? 24,
            width: suffixIconStyle!.textFieldWidth ?? 24,
          )
              : Icon(
            suffixIconStyle!.icon,
            size: suffixIconStyle!.textFieldHeight ?? 24,
          ),
        )
            : null,
        insideColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.15),
        enableBorderColor: borderStyle.enabledBorderColor,
        focusedColor: borderStyle.focusedBorderColor,
        radius: borderStyle.radius);

    //   InputDecoration(
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(borderStyle.radius),
    //     borderSide: BorderSide(
    //       color: borderStyle.enabledBorderColor,
    //       width: borderStyle.borderWidth,
    //     ),
    //   ),
    //   disabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(borderStyle.radius),
    //     borderSide: BorderSide(
    //       color: borderStyle.disabledBorderColor,
    //       width: borderStyle.borderWidth,
    //     ),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(borderStyle.radius),
    //     borderSide: BorderSide(
    //       color: borderStyle.focusedBorderColor,
    //       width: borderStyle.borderWidth,
    //     ),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(borderStyle.radius),
    //     borderSide: BorderSide(
    //       color: borderStyle.errorBorderColor,
    //       width: borderStyle.borderWidth,
    //     ),
    //   ),
    // );
  }
}

class CustomTextField extends StatelessWidget {
  final String name;
  final CustomTextFieldProperties properties;
  final CustomInputTextStyle? inputTextStyle;
  final Color? cursorColor;
  final bool? isEnable;
  final String? initialValue;
  final CustomInputDecorationStyle inputDecorationStyle;

  const CustomTextField({
    super.key,
    required this.name,
    required this.properties,
    this.inputTextStyle,
    this.cursorColor = Colors.black,
    this.isEnable = true,
    required this.inputDecorationStyle,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      validator: properties.validator ?? null,
      enabled: isEnable ?? false,
      controller: properties.controller,
      keyboardType: properties.keyboardTypes,
      // onChanged: properties.onChangedFunc,
      onChanged: (value) {
        if (properties.onChangedFunc != null && value is String) {
          properties.onChangedFunc!(value);
        }
      },
      obscureText: properties.obscureText,
      maxLines: properties.maxLines,
      style: inputTextStyle?.style,
      enableSuggestions: properties.enabledSuggestions,
      decoration: inputDecorationStyle.decoration(context),
      cursorColor: cursorColor,
      initialValue: initialValue,
    );
  }
}
