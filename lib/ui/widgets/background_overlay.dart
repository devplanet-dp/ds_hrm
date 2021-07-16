import 'package:flutter/material.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';

class BackgroundOverlayWidget extends StatelessWidget {
  final isDark;

  const BackgroundOverlayWidget({Key? key, this.isDark = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight(percent: 1),
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            !isDark
                ? Colors.grey[300]!.withOpacity(.7)
                : Colors.black.withOpacity(.9),
            !isDark
                ? Colors.grey[300]!.withOpacity(.1)
                : Colors.black.withOpacity(.3)
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
    );
  }
}