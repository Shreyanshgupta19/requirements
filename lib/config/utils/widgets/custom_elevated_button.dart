import 'package:flutter/material.dart';

class CustomButtonProperties {
  final Widget? child;
  final double width;
  final double height;
  final double? radius;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  CustomButtonProperties({
    required this.child,
    required this.width,
    required this.height,
    this.radius,
    this.onPressed,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
  });
}

class CustomElevatedButton extends StatelessWidget {
  final CustomButtonProperties properties;

  const CustomElevatedButton({
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: properties.width,
      height: properties.height,
      child: ElevatedButton(
        onPressed: properties.onPressed,
        child: properties.child ?? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: properties.backgroundColor ?? Colors.blue,
          foregroundColor: properties.foregroundColor ?? Colors.white,
          textStyle: properties.textStyle ?? TextStyle(fontSize: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(properties.radius ?? 10),
          ),
        ),
      ),
    );
  }
}
