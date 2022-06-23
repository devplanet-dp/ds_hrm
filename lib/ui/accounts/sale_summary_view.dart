import 'package:ds_hrm/viewmodel/accounts/sale_view_model.dart';
import 'package:ds_hrm/viewmodel/accounts/sale_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../model/item.dart';
import '../../utils/app_utils.dart';
import '../../viewmodel/accounts/item_view_model.dart';
import '../shared/app_colors.dart';
import '../shared/shared_styles.dart';
import '../shared/ui_helpers.dart';
import '../widgets/app_stream_list.dart';
import '../widgets/busy_overlay.dart';
import '../widgets/text_field_widget.dart';
import 'add_item_view.dart';

class SaleSummaryView extends StatelessWidget {
  const SaleSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SaleViewModel>.reactive(
      onModelReady: (model)=>model.onValueChanged(''),
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          body: SafeArea(
            child: _buildStockItems(model),
          ),
        ),
      ),
      viewModelBuilder: () => SaleViewModel(),
    );
  }

  _buildStockItems(SaleViewModel model) => Column(
        children: [
          SizedBox(
            width: Get.width / 3,
            child: AppTextField(
              controller: model.searchItemTEC,
              borderColor: kBgDark.withOpacity(0.4),
              fillColor: Colors.transparent,
              hintText: 'Search items here..',
              prefixIcon: const Icon(Icons.search),
              onChanged: model.onValueChanged,
            ),
          ),
          verticalSpaceMedium,
          const _TableHeaders(),
          verticalSpaceSmall,
          AppStreamList(
              stream: model.searchItems(),
              itemBuilder: (index, emp) {
                Item u = emp as Item;
                bool _isSelected = u.id == model.selectedItem?.id;
                return InkWell(
                  child: Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide(width: 1, color: kcPrimaryColor),
                        outside: BorderSide(width: 1, color: kcPrimaryColor)),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(kRadiusMedium)),
                              color: _isSelected
                                  ? kcPrimaryColorLight.withOpacity(0.2)
                                  : Colors.transparent),
                          children: [
                            TableContent(value: u.name),
                            TableContent(value: u.price),
                            TableContent(value: u.issuedAmount.toString()),
                            TableContent(value: u.amount.toString()),
                            TableContent(value: getFormattedDate(u.createdAt)),
                            TableContent(
                                value: getFormattedDate(u.lastUpdated)),
                          ])
                    ],
                  ),
                );
              },
              emptyIcon: Icons.supervised_user_circle_outlined,
              emptyText: 'No items found',
              separator: EmptyBox,
              isDark: model.isDark())
        ],
      );
}

class _TableHeaders extends StatelessWidget {
  const _TableHeaders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
      },
      children: const [
        TableRow(children: [
          TableHeader(title: 'Name'),
          TableHeader(title: 'Unit price'),
          TableHeader(title: 'Issued'),
          TableHeader(title: 'Available'),
          TableHeader(title: 'Created at'),
          TableHeader(title: 'Last updated'),
        ])
      ],
    );
  }
}
