import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

import 'app_info.dart';

class AppStreamList extends StatelessWidget {
  final Stream stream;
  final Widget Function(int, dynamic) itemBuilder;
  final IconData emptyIcon;
  final String emptyText;
  final bool isDark;
  final Widget separator;

  const AppStreamList(
      {Key? key,
      required this.stream,
      required this.itemBuilder,
      required this.emptyIcon,
      required this.emptyText,
      required this.isDark,
      this.separator = verticalSpaceSmall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<dynamic> data = snapshot.data as List<dynamic>;
          if (data.isEmpty) {
            return AppInfoWidget(
              translateKey: emptyText,
              iconData: emptyIcon,
              isDark: isDark,
              icon: null,
            );
          }
          return ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => itemBuilder(index, data[index]),
            separatorBuilder: (_, index) => separator,
          );
        });
  }
}
