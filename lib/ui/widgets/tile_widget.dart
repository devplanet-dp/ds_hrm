import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/utils/margin.dart';
import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final Widget header;
  final String subHeader;
  final IconData icon;
  final Color primaryColor;
  final VoidCallback onTap;
  final bool isDark;

  const TileWidget(
      {Key? key,
      required this.header,
      required this.subHeader,
      required this.icon,
      required this.primaryColor,
      required this.onTap,
      required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: context.screenHeight(percent: 0.25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color: isDark ? Colors.white24 : Colors.black12,
                  offset: Offset(0.0, 4.0))
            ],
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                primaryColor.withOpacity(0.6),
                primaryColor.withOpacity(0.7),
                primaryColor.withOpacity(0.8),
                primaryColor.withOpacity(0.9),
              ],
            )),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(top: 20, left: 10, child: header),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(5),
                  Text(
                    subHeader,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
