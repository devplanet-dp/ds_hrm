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

class LandDrawerViewModel extends BaseModel {
  List<DrawerItem> _drawerTools = [
    DrawerItem(title: 'dashboard'.tr(), icon: Icons.dashboard_outlined, id: 1),
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

class AccountDrawerViewModel extends BaseModel {
  final List<DrawerItem> _drawerTools = [
    DrawerItem(title: 'Add a Sale', icon: Icons.add_sharp, id: 1),
    DrawerItem(title: 'Summary', icon: Icons.assessment_outlined, id: 2),
    DrawerItem(title: 'Register', icon: Icons.border_color_outlined, id: 3),
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
class SocialDrawerViewModel extends BaseModel {
  final List<DrawerItem> _drawerTools = [
    DrawerItem(title: 'Dashboard', icon: Icons.assessment_outlined, id: 1),
    DrawerItem(title: 'Add members', icon: Icons.border_color_outlined, id: 2),
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
