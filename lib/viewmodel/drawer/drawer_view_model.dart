import 'package:ds_hrm/model/drawer_item.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DrawerViewModel extends BaseModel {


  List<DrawerItem> _drawerTools = [
    DrawerItem(title: 'dashboard'.tr(), icon: Icons.dashboard_outlined, id: 1),
    DrawerItem(
        title: 'staff'.tr(),
        icon: Icons.supervised_user_circle_outlined,
        id: 2),
    DrawerItem(title: 'language'.tr(), icon: Icons.language, id: 3),
    DrawerItem(title: 'sign_out'.tr(), icon: LineIcons.alternateSignOut, id: 4),
  ];
  int _selectedTool = 0;

  int get selectedTool => _selectedTool;

  void setSelectedTool(int id) {
    _selectedTool = id;
    notifyListeners();
  }

  bool isToolSelected(int currentId) => selectedTool == currentId;

  List<DrawerItem> get drawerTools => _drawerTools;
}
