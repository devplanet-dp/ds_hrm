import 'package:ds_hrm/constants/app_assets.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final double radius;
  final double elevation;

  const AppLogoWidget({Key? key, this.radius = 4, this.elevation = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: elevation,
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        kIcDSLogo,
        width: 72,
        height: 72,
      ),
    );
  }
}
