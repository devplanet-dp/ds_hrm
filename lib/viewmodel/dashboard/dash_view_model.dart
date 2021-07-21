import 'package:ds_hrm/model/division.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';

class DashViewModel extends BaseModel {
  final _firestoreService = locator<FirestoreService>();

  final searchTEC = TextEditingController();

  Future addDivision() async {
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
    div.forEach((e) async {
      setBusy(true);
      await _firestoreService.createDivision(e);
      setBusy(false);
    });
  }

  Stream<List<Employee>> streamEmployees() =>
      _firestoreService.streamEmployees();

  //region division
  List<Division> _adminDivision = [];

  List<Division> get adminDivision => _adminDivision;

  Future getAdminDivisions() async {
    var result =
        await _firestoreService.getDivisions(FirestoreService.TB_DIVISION);
    if (!result.hasError) {
      _adminDivision = result.data as List<Division>;
      notifyListeners();
    }
  }

  //endregion

  //region search
  String _searchKey = '';

  List<Employee> _employees = [];

  List<Employee> get employees => _employees;

  bool get isSearch => _searchKey.isNotEmpty;

  bool _isSearch = false;

  onValueChanged(String value) {
    _searchKey = value;
    notifyListeners();
  }

  void requestMoreData() => _firestoreService.requestMoreEmployees(_searchKey);

  void listenToEmp() {
    setBusy(true);
    _employees.clear();
    _firestoreService.listenToEmployeesRealTime(_searchKey).listen((userData) {
      List<Employee> updatedUsers = userData;
      if (updatedUsers.length > 0) {
        _employees = updatedUsers;
      }
    });
    setBusy(false);
  }


  //endregion

  @override
  void dispose() {
    searchTEC.dispose();
    super.dispose();
  }
}
