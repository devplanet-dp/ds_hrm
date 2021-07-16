import 'package:ds_hrm/model/division.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';

import '../../locator.dart';

class DashViewModel extends BaseModel{
  final _firestoreService = locator<FirestoreService>();

  Future addDivision()async{
    List<Division> div = [
      Division(title: 'Bandarawela East', code: '65G'),
      Division(title: 'Bandarawela West', code: '65B'),
      Division(title: 'Kinigama', code: '70C'),
      Division(title: 'Kabillewela South', code: '67C'),
      Division(title: 'Doolgolla', code: '67C'),
      Division(title: 'Obadaella', code: '67C'),
      Division(title: 'Kirioruwa', code: '67C'),
      Division(title: 'Konthehela', code: '67C'),

    ];
    div.forEach((e) async{
      setBusy(true);
      await _firestoreService.createDivision(e);
      setBusy(false);
    });
  }
}