import 'package:flutter/cupertino.dart';

class DrawerItem {
  late final String title;
  late final IconData icon;
  late final int id;

  DrawerItem({required this.title, required this.icon, required this.id});

  bool isSelected(int selectedId) => selectedId == this.id;
}
