import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/division.dart';
import 'package:ds_hrm/model/education.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../locator.dart';

class StaffViewModel extends BaseModel {
  //services
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  final formKey = GlobalKey<FormState>();

  ///text controller
  final firstNameTEC = TextEditingController();
  final lastNameTEC = TextEditingController();
  final dobTEC = TextEditingController();
  final nicTEC = TextEditingController();
  final addressTEC = TextEditingController();
  final divisionTEC = TextEditingController();
  final emailTEC = TextEditingController();
  final mobileTEC = TextEditingController();
  final emergeNameTEC = TextEditingController();
  final emergeMobileTEC = TextEditingController();
  final empCodeTEC = TextEditingController();
  final designationTEC = TextEditingController();
  final dpHeadTEC = TextEditingController();
  final extensionTEC = TextEditingController();
  final joinedDateTEC = TextEditingController();
  final remarkTEC = TextEditingController();
  final adminDivisionTEC = TextEditingController();
  final institutionTEC = TextEditingController();
  final nameTEC = TextEditingController();
  final yearTEC = TextEditingController();
  final descTEC = TextEditingController();

  //region division
  List<Division> _devDivision = [];

  List<Division> get devDivision => _devDivision;

  void setDivision(String value) {
    divisionTEC.text = value;
    notifyListeners();
    _navigationService.back();
  }

  Future getDevDivisions() async {
    setBusy(true);
    var result =
        await _firestoreService.getDivisions(FirestoreService.TB_DEV_DIVISION);
    setBusy(false);
    if (!result.hasError) {
      _devDivision = result.data as List<Division>;
      notifyListeners();
    } else {
      _dialogService.showDialog(
          title: 'Oops', description: result.errorMessage);
    }
  }

  //endregion

  //region admin division
  List<Division> _adminDivision = [];

  List<Division> get adminDivision => _adminDivision;

  void setAdminDivision(String value) {
    adminDivisionTEC.text = value;
    notifyListeners();
    _navigationService.back();
  }

  Future getAdminDivisions() async {
    setBusy(true);
    var result =
        await _firestoreService.getDivisions(FirestoreService.TB_DIVISION);
    setBusy(false);
    if (!result.hasError) {
      _adminDivision = result.data as List<Division>;
      notifyListeners();
    } else {
      _dialogService.showDialog(
          title: 'Oops', description: result.errorMessage);
    }
  }

  //endregion

  //region template
  //endregion

  ///region dob
  late DateTime _dob;

  DateTime get dob => _dob;

  void setDOB(DateTime? dateTime) {
    _dob = dateTime!;
    dobTEC.text = '${dateTime.year}/${dateTime.month}/${dateTime.day}';
    notifyListeners();
  }

  ///endregion

  //region gender
  Gender _gender = Gender.Male;

  Gender get selectedGender => _gender;

  bool isGenderSelected(Gender type) => selectedGender == type;

  void setGender(Gender type) {
    _gender = type;
    notifyListeners();
  }

  //endregion

  //region nationality
  Nationality _nationality = Nationality.Sinhala;

  Nationality get selectedNationality => _nationality;

  bool isNationalitySelected(Nationality type) => selectedNationality == type;

  void setNationality(Nationality type) {
    _nationality = type;
    notifyListeners();
  }

  //endregion

  //region religion
  Religion _religion = Religion.Buddhism;

  Religion get selectedReligion => _religion;

  bool isReligionSelected(Religion type) => selectedReligion == type;

  void setReligion(Religion type) {
    _religion = type;
    notifyListeners();
  }

  //endregion

  //region married
  bool _isMarried = false;

  bool get isMarried => _isMarried;

  toggleMarried() {
    _isMarried = !_isMarried;
    notifyListeners();
  }

  //endregion

  //region joined date
  late DateTime _joinedDate;

  DateTime get joinedDate => _joinedDate;

  void setJoinedDate(DateTime? dateTime) {
    _joinedDate = dateTime!;
    joinedDateTEC.text = '${dateTime.year}/${dateTime.month}/${dateTime.day}';
    notifyListeners();
  }

  //endregion

  //region work location
  WorkLocation _workLocation = WorkLocation.Office;

  WorkLocation get selectedWorkLocation => _workLocation;

  bool isWorkLocationSelected(WorkLocation type) =>
      selectedWorkLocation == type;

  void setWorkLocation(WorkLocation type) {
    _workLocation = type;
    notifyListeners();
  }

  //endregion

  //region course type
  CourseType _courseType = CourseType.Degree;

  CourseType get selectedCourseType => _courseType;

  bool isCourseTypeSelected(CourseType type) => selectedCourseType == type;

  void setCourseType(CourseType type) {
    _courseType = type;
    notifyListeners();
  }

  //endregion

  //region education
  List<Education> _education = [];

  List<Education> get education => _education;

  void addEducation() {
    Education e = Education(
        institution: institutionTEC.text,
        name: nameTEC.text,
        year: yearTEC.text,
        desc: descTEC.text,
        courseType: selectedCourseType,
        id: Uuid().v4());

    _education.add(e);
    _resetEducationFields();
    notifyListeners();
  }

  void removeEducation(String id) {
    _education.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void _resetEducationFields() {
    institutionTEC.text = '';
    nameTEC.text = '';
    yearTEC.text = '';
    descTEC.text = '';
  }

  //endregion

  Future addStaff() async {
    setBusy(true);
    Employee e = Employee(
        id: Uuid().v4(),
        firstName: firstNameTEC.text,
        lastName: lastNameTEC.text,
        nic: nicTEC.text,
        dob: Timestamp.fromDate(dob),
        address: addressTEC.text,
        division: divisionTEC.text,
        mobileNumber: mobileTEC.text,
        email: emailTEC.text,
        gender: selectedGender,
        nationality: selectedNationality,
        religion: selectedReligion,
        maritalStatus: isMarried,
        designation: designationTEC.text,
        empCode: empCodeTEC.text,
        head: dpHeadTEC.text,
        department: adminDivisionTEC.text,
        workLocation: selectedWorkLocation,
        extention: extensionTEC.text,
        joinedDate: Timestamp.fromDate(joinedDate),
        emergeContactName: emergeNameTEC.text,
        emergeMobileNumber: emergeMobileTEC.text,
        remark: remarkTEC.text,
        searchName: firstNameTEC.text.toLowerCase().trim() +
            lastNameTEC.text.toLowerCase().trim(),
        education: []);

    var result = await _firestoreService.createEmployee(
        employee: e, qualification: education);
    setBusy(false);
    if (!result.hasError) {
      _dialogService.showDialog(
          title: 'Success', description: 'Employee added successfully!');
      _resetView();
    } else {
      _dialogService.showDialog(
          title: 'Sorry', description: result.errorMessage);
    }
  }

  void _resetView() {
    firstNameTEC.text = '';
    lastNameTEC.text = '';
    dobTEC.text = '';
    nicTEC.text = '';
    addressTEC.text = '';
    divisionTEC.text = '';
    emergeNameTEC.text = '';
    emergeMobileTEC.text = '';
    empCodeTEC.text = '';
    designationTEC.text = '';
    dpHeadTEC.text = '';
    extensionTEC.text = '';
    joinedDateTEC.text = '';
    remarkTEC.text = '';
    institutionTEC.text = '';
    yearTEC.text = '';
    descTEC.text = '';
    mobileTEC.text = '';
    emailTEC.text = '';
    adminDivisionTEC.text = '';
    education.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    dobTEC.dispose();
    nicTEC.dispose();
    addressTEC.dispose();
    divisionTEC.dispose();
    emergeNameTEC.dispose();
    emergeMobileTEC.dispose();
    empCodeTEC.dispose();
    designationTEC.dispose();
    dpHeadTEC.dispose();
    extensionTEC.dispose();
    joinedDateTEC.dispose();
    remarkTEC.dispose();
    institutionTEC.dispose();
    yearTEC.dispose();
    descTEC.dispose();

    super.dispose();
  }
}
