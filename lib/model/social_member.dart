import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/division.dart';
import 'package:ds_hrm/model/donation_type.dart';

class SocialMember {
  String? id;
  String? name;
  String? nic;
  Timestamp? createdAt;
  String? address;
  Timestamp? dob;
  String? mobile;
  DonationType? donationType;
  Division? gnDivision;
  String? searchName;

  SocialMember(
      {this.id,
        this.name,
        this.nic,
        this.createdAt,
        this.address,
        this.dob,
        this.searchName,
        this.mobile,
        this.donationType,
        this.gnDivision});

  SocialMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nic = json['nic'];
    createdAt = json['createdAt'];
    address = json['address'];
    dob = json['dob'];
    searchName = json['search_name'];
    mobile = json['mobile'];
    donationType = DonationType.fromJson(json['donation_type']);
    gnDivision = Division.fromMap(json['gn_division']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nic'] = this.nic;
    data['createdAt'] = this.createdAt;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['search_name'] = this.searchName;
    data['donation_type'] = this.donationType?.toJson();
    data['gn_division'] = this.gnDivision?.toJson();
    return data;
  }
}