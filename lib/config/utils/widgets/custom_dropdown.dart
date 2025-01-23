import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropDownProperties<T> {
  final double dropDownHeight;
  final double dropDownWidth;
  final double? topPadding;
  final double? bottomPadding;
  final double? rightPadding;
  final double? leftPadding;
  final String name;
  final String hintText;
  final TextStyle? selectedTextStyle;
  final TextStyle? hintTextStyle;
  final String? labelText;
  final Color? labelColor;
  final Color enableBorderColor;
  final Color disableBorderColor;
  final Color focusedBorderColor;
  final Color? dropDownBackgroundColor;
  final Color? iconEnableColor;
  final List<DropdownMenuItem<T>> items;
  final T? initialValue;
  final Widget? icon;
  final void Function(T?)? onChange;
  final void Function()? onTapped;
  final void Function()? oNReset;
  final String? Function(T?)? validator;

  DropDownProperties({
    required this.dropDownHeight,
    required this.dropDownWidth,
    required this.hintText,
    this.hintTextStyle,
    this.topPadding,
    this.bottomPadding,
    this.leftPadding,
    this.rightPadding,
    required this.name,
    this.labelText,
    this.labelColor,
    this.selectedTextStyle,
    this.icon,
    required this.enableBorderColor,
    required this.disableBorderColor,
    required this.focusedBorderColor,
    this.dropDownBackgroundColor,
    this.iconEnableColor,
    required this.items,
    this.initialValue,
    this.onChange,
    this.validator,
    this.onTapped,
    this.oNReset,
  });
}

class CustomDropDown<T> extends StatelessWidget {
  final DropDownProperties<T> properties;
  final bool isEnable;

  CustomDropDown({super.key, required this.properties, this.isEnable = true,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: properties.leftPadding ?? 0,
        right: properties.rightPadding ?? 0,
        top: properties.topPadding ?? 0,
        bottom: properties.bottomPadding ?? 0,
      ),
      child: Container(
        height: properties.dropDownHeight,
        width: properties.dropDownWidth,
        child: DropdownButtonHideUnderline(
          child: FormBuilderDropdown<T>(
            name: properties.name,
            enabled: isEnable,
            hint: Text(
              properties.hintText,
              style: properties.hintTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              labelText: properties.labelText,
              labelStyle: TextStyle(
                color: properties.labelColor,
                fontSize: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,  // This ensures label is always shown above
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: properties.enableBorderColor,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: properties.disableBorderColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: properties.focusedBorderColor,
                  width: 2,
                ),
              ),
            ),
            autofocus: false,
            isDense: true,
            style: properties.selectedTextStyle,
            icon: properties.icon ?? const Icon(Icons.arrow_drop_down_sharp),
            iconEnabledColor: properties.iconEnableColor,
            initialValue: properties.initialValue,
            items: properties.items,
            onChanged: properties.onChange,
            isExpanded: true,
            dropdownColor: properties.dropDownBackgroundColor,
            validator: properties.validator,
            onTap: properties.onTapped,
          ),
        ),
      ),
    );
  }
}
