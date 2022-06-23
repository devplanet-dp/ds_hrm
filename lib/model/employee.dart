import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/education.dart';

enum Religion { Buddhism, Hinduism, Islam, Christian }

enum WorkLocation { Office, Field }

enum Nationality { Sinhala, Tamil, Muslim, Burgher }
enum Gender {
  Male,
  Female,
}
enum SearchType{
  name,
  nic,
  mobile
}

class Employee {
  late String id;
  late String? firstName;
  late String? lastName;
  late String? nic;
  late Timestamp? dob;
  late String? address;
  late String? division;
  late String? mobileNumber;
  late String? email;
  late Gender? gender;
  late Nationality? nationality;
  late Religion? religion;
  late bool? maritalStatus;
  late String? designation;
  late String? empCode;
  late String? head;
  late String? department;
  late WorkLocation? workLocation;
  late String? extention;
  late Timestamp? joinedDate;
  late String? emergeContactName;
  late String? emergeMobileNumber;
  late String? remark;
  late List<Education> education;
  late String? searchName;

  Employee(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.nic,
      required this.dob,
      required this.address,
      required this.division,
      required this.mobileNumber,
      required this.email,
      required this.gender,
      required this.nationality,
      required this.religion,
      required this.maritalStatus,
      required this.designation,
      required this.empCode,
      required this.head,
      required this.department,
      required this.workLocation,
      required this.extention,
      required this.joinedDate,
      required this.emergeContactName,
      required this.emergeMobileNumber,
      required this.education,
      required this.searchName,
      required this.remark});

  Employee.fromMap(Map<String, dynamic> json) {
    try {
      id = json['id'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      nic = json['nic'];
      dob = json['dob'];
      address = json['address'];
      division = json['division'];
      mobileNumber = json['mobileNumber'];
      email = json['email'];
      gender = Gender.values.elementAt(json['gender'] ?? 1);
      nationality = Nationality.values.elementAt(json['nationality'] ?? 1);
      religion = Religion.values.elementAt(json['religion'] ?? 1);
      maritalStatus = json['maritalStatus'];
      designation = json['designation'];
      empCode = json['empCode'];
      head = json['head'];
      searchName = json['searchName'];
      department = json['department'];
      workLocation = WorkLocation.values.elementAt(json['work_location'] ?? 1);
      extention = json['extention'];
      joinedDate = json['joinedDate'];
      emergeContactName = json['emergeContactName'];
      emergeMobileNumber = json['emergeMobileNumber'];
      remark = json['remark'];
      education = (List.from(json['education'] ?? []))
          .map((e) => Education.fromMap(e))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['nic'] = this.nic;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['division'] = this.division;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['gender'] = this.gender!.index;
    data['nationality'] = this.nationality!.index;
    data['religion'] = this.religion!.index;
    data['maritalStatus'] = this.maritalStatus;
    data['designation'] = this.designation;
    data['empCode'] = this.empCode;
    data['head'] = this.head;
    data['searchName'] = this.searchName;
    data['department'] = this.department;
    data['work_location'] = this.workLocation!.index;
    data['extention'] = this.extention;
    data['joinedDate'] = this.joinedDate;
    data['emergeContactName'] = this.emergeContactName;
    data['emergeMobileNumber'] = this.emergeMobileNumber;
    data['remark'] = this.remark;
    return data;
  }

  Employee.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);
}
/*
{
"firstName": "",
"lastName": "",
"nic": "",
"dob": "",
"address": "",
"division": "",
"mobileNumber": "",
"email": "",
"gender": "",
"nationality": "",
"religion": "",
"maritalStatus": "",
"designation": "",
"empCode": "",
"head": "",
"department": "",
"work_location": "",
"extention": "",
"joinedDate": "",
"emergeContactName": "",
"emergeMobileNumber": "",
"remark": ""
}*/
