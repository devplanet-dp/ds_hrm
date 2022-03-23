import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  String? id;
  String? name;
  String? designation;
  String? branchId;
  String? branchName;
  Timestamp? createdAt;
  String? fileNo;
  List<SaleItem>? items;

  Sale(
      {this.id,
      this.name,
      this.designation,
      this.branchId,
      this.branchName,
      this.createdAt,
      this.fileNo,
      this.items});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    designation = json['designation'];
    branchId = json['branchId'];
    branchId = json['branchName'];
    createdAt = json['createdAt'];
    fileNo = json['fileNo'];
    items = (List.from(json['items'] ?? []))
        .map((e) => SaleItem.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['createdAt'] = this.createdAt;
    data['fileNo'] = this.fileNo;
    data['items'] = this.items;
    return data;
  }
}

class SaleItem {
  String? id;
  String? name;
  String? requestedAmount;
  String? issuedAmount;

  SaleItem({this.id, this.name, this.requestedAmount, this.issuedAmount});

  SaleItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    requestedAmount = json['requested_amount'];
    issuedAmount = json['issued_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['requested_amount'] = this.requestedAmount;
    data['issued_amount'] = this.issuedAmount;
    return data;
  }
}
