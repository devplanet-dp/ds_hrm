import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/education.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../locator.dart';
import 'base_model.dart';

class TemplateViewModel extends BaseModel {
  final _firestoreService = locator<FirestoreService>();
  final _dialogService = locator<DialogService>();

  Future addStaff() async {
    setBusy(true);
    Employee e = Employee(
        id: '11',
        firstName: '',
        lastName: '',
        nic: '',
        dob: Timestamp.now(),
        address: 'address',
        division: 'division',
        mobileNumber: 'mobileNumber',
        email: 'email',
        gender: Gender.Male,
        nationality: Nationality.Burgher,
        religion: Religion.Buddhism,
        maritalStatus: false,
        designation: 'designation',
        empCode: 'empCode',
        head: 'head',
        department: 'department',
        workLocation: WorkLocation.Office,
        extention: 'extention',
        joinedDate: Timestamp.now(),
        emergeContactName: 'emergeContactName',
        emergeMobileNumber: 'emergeMobileNumber',
        remark: 'remark', education: [], searchName: '');

    List<Education> edu = [];
    Education education = Education(
        institution: '',
        name: 'name',
        year: 'year',
        desc: 'desc',
        courseType: CourseType.Degree,
        id: 'idasdasd');
    edu.add(education);
    edu.add(education);
    edu.add(education);
    var result =
        await _firestoreService.createEmployee(employee: e, qualification: edu);
    setBusy(false);
    if (!result.hasError) {
      _dialogService.showDialog(
          description: 'Success', title: 'Employee added successfully!');
    } else {
      _dialogService.showDialog(
          title: 'Sorry', description: result.errorMessage);
    }
  }
}
