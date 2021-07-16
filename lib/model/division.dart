import 'package:cloud_firestore/cloud_firestore.dart';

class Division {
  late String title;
  late String code;
  late int sortOrder;

  Division({required this.title, required this.code, this.sortOrder = 1});

  Division.fromMap(Map<String, dynamic>?  json) {
    title = json!['title'];
    code = json['code'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['code'] = this.code;
    data['sort_order'] = this.sortOrder;
    return data;
  }

  Division.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);
}
