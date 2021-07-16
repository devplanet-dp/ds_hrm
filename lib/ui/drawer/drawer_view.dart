import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/constants/app_assets.dart';
import 'package:ds_hrm/model/drawer_item.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/viewmodel/drawer/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DrawerView extends StatelessWidget {
  Function(int) selectedIndex;

  DrawerView({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerViewModel>.reactive(
      onModelReady: (model){
        model.setSelectedTool(1);
      },
      builder: (context, model, child) => Drawer(
        child: Material(
          elevation: 0,
          color: kcPrimaryColor,
          child: ListView(
            padding: fieldPaddingAll,
            children: [
              Material(
                shape: RoundedRectangleBorder(borderRadius: kBorderSmall),
                color: kcPrimaryColorLight.withOpacity(0.4),
                child: ListTile(
                  leading: Image.asset(kIcDSLogo),
                  title: AutoSizeText(
                    'HRM',
                    style: kBodyStyle.copyWith(
                        color: kAltWhite,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 8),
                    maxLines: 1,
                  ),
                  isThreeLine: true,
                  subtitle: AutoSizeText(
                    'Divisional Secretariat',

                    style: kCaptionStyle.copyWith(fontSize: 8,color: kAltWhite),
                  ),
                ),
              ),
              verticalSpaceSmall,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    model.drawerTools.length,
                    (index) => _DrawerItem(
                        item: model.drawerTools[index],
                        onTapped: () {
                          selectedIndex(index);
                          model.setSelectedTool(model.drawerTools[index].id);
                        },
                        isSelected:
                            model.isToolSelected(model.drawerTools[index].id))),
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
      viewModelBuilder: () => DrawerViewModel(),
    );
  }

  Widget _buildDrawerSubHeader(String title) => Padding(
        padding: fieldPadding,
        child: AutoSizeText(
          title,
          style: kBodyStyle.copyWith(color: kAltWhite),
          maxLines: 1,
        ),
      );
}

class _DrawerItem extends StatelessWidget {
  final DrawerItem item;
  final VoidCallback onTapped;
  final bool isSelected;

  const _DrawerItem({
    Key? key,
    required this.item,
    required this.onTapped,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      shape: RoundedRectangleBorder(borderRadius: kBorderSmall),
      selectedTileColor: kcPrimaryColorDark,
      onTap: onTapped,
      leading: Icon(
        item.icon,
        color: isSelected ? Colors.white : kAltWhite.withOpacity(0.5),
      ),
      title: AutoSizeText(
        item.title,
        maxLines: 1,
        style: kBodyStyle.copyWith(
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w200,
            color: isSelected ? Colors.white : kAltWhite.withOpacity(0.5)),
      ),
    );
  }
}
