import 'package:flutter/material.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final Color bgColor;

  const RoundButton({Key? key, required this.onTap, required this.icon, this.bgColor = kAltWhite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      shape: CircleBorder(),
      elevation: 2,
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
    );
  }
}
