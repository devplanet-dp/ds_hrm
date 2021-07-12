import 'package:ds_hrm/model/division.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';

import '../../locator.dart';

class DashViewModel extends BaseModel{
  final _firestoreService = locator<FirestoreService>();

  Future addDivision()async{
    List<Division> div = [
      Division(title: 'Establishment and Human Resource', code: 'EHR'),
      Division(title: 'Social Service and Welfare', code: 'SSW'),
      Division(title: 'Development Planning', code: 'DP'),
      Division(title: 'Financial Management', code: 'FM'),
      Division(title: 'Registrar', code: 'RG'),
      Division(title: 'Land', code: 'LND'),
      Division(title: 'Samurdhi', code: 'SMD'),
      Division(title: 'Field', code: 'FD'),
    ];
    div.forEach((e) async{
      setBusy(true);
      await _firestoreService.createDivision(e);
      setBusy(false);
    });
  }
}