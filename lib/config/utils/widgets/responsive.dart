import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile, tablet, desktop;
  const Responsive({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  static bool isMobile(BuildContext c) {
    if (MediaQuery.of(c).orientation == Orientation.landscape) {
      return MediaQuery.of(c).size.width < 1280 &&
          MediaQuery.of(c).size.height < 420;
    } else {
      return MediaQuery.of(c).size.width < 840;
    }
  }

  static bool isTablet(BuildContext c) {
    return MediaQuery.of(c).size.width >= 840 &&
        MediaQuery.of(c).size.width < 1280;
  }

  static bool isDesktop(BuildContext c) => MediaQuery.of(c).size.width >= 1280;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
}
