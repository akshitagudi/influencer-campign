import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    if (size > 1024) {
      return desktop;
    } else if (size > 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
