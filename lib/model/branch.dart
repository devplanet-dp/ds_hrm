import 'package:cloud_firestore/cloud_firestore.dart';
class Branch {
 late String id;
 late String name;
 late String query;

  Branch({required this.id, required this.name,required this.query});

  Branch.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json['name'];
    query = json['query'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
 Branch.fromSnapshot(DocumentSnapshot snapshot) : this.fromJson(snapshot.data()as Map<String,dynamic>);
}