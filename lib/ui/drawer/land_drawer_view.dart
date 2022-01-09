import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/constants/app_assets.dart';
import 'package:ds_hrm/model/drawer_item.dart';
import 'package:ds_hrm/ui/drawer/drawer_view.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/viewmodel/drawer/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LandDrawerView extends StatelessWidget {
  Function(int) selectedIndex;

  LandDrawerView({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandDrawerViewModel>.reactive(
      onModelReady: (model) {
        model.setSelectedTool(1);
      },
      builder: (context, model, child) => Drawer(
        child: Material(
          elevation: 0,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: const EdgeInsets.only(right: 12.0),
            children: [
              ListTile(
                leading: Image.asset(kIcDSLogo),
                title: AutoSizeText(
                  'Land',
                  style: kBodyStyle.copyWith(
                      color: kAltBg,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 8),
                  maxLines: 1,
                ),
                isThreeLine: true,
                subtitle: AutoSizeText(
                  'Divisional Secretariat',
                  style: kCaptionStyle.copyWith(fontSize: 8, color: kAltBg),
                ),
              ),
              verticalSpaceSmall,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    model.drawerTools.length,
                        (index) => DrawerWidget(
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
      viewModelBuilder: () => LandDrawerViewModel(),
    );
  }

}

