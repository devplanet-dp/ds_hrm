import 'package:ds_hrm/ui/views/lease/lease_view.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class LandDashViewModel extends BaseModel {
  toLeasingView() => Get.to(() => TaxView());
}
