import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/viewmodel/_templat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TemplateView extends StatelessWidget {
  const TemplateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TemplateViewModel>.reactive(
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          body: Center(
            child: TextButton(
                child: Text('Add'), onPressed: () => model.addStaff()),
          ),
        ),
      ),
      viewModelBuilder: () => TemplateViewModel(),
    );
  }
}
