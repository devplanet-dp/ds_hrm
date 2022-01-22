import 'package:cloud_firestore/cloud_firestore.dart';

enum Department { ADMIN, LAND, ACCOUNT }

class UserModel {
  late String name;
  late String email;
  late String profileUrl;
  late String userId;
  late bool isActive;
  late Timestamp createdDate;
  late bool isAdmin;
  late bool isSuperAdmin;
  late Department department;

  UserModel(
      {required this.name,
      required this.email,
      this.profileUrl = '',
      required this.userId,
      required this.createdDate,
      this.isAdmin = false,
      required this.isSuperAdmin,
      this.isActive = true});

  UserModel.fromMap(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    profileUrl = json['profileUrl'];
    userId = json['userId'];
    isActive = json['isActive'];
    isAdmin = json['isAdmin'];
    isSuperAdmin = json['isSuperAdmin'];
    createdDate = json['createdDate'];
    department = Department.values[json['department'] ?? 0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['profileUrl'] = this.profileUrl;
    data['userId'] = this.userId;
    data['isAdmin'] = this.isAdmin;
    data['isSuperAdmin'] = this.isSuperAdmin;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    return data;
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}
