import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  late String id;
  late String name;
  late String price;
  late String query;
  late int amount;
  late int issuedAmount;
  late String docId;
  late Timestamp createdAt;
  late Timestamp lastUpdated;

  Item(
      {required this.id,
      required this.name,
      required this.price,
      required this.query,
      required this.createdAt,
      required this.lastUpdated,
      this.issuedAmount = 0,
      required this.amount});

  Item.fromJson(Map<String, dynamic>? json, String doc) {
    id = json!['id'];
    name = json['name'];
    price = json['price'];
    query = json['query'];
    amount = json['amount'];
    issuedAmount = json['issued_amount'];
    createdAt = json['created_at'];
    lastUpdated = json['last_updated'];
    docId = doc;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['query'] = query;
    data['amount'] = amount;
    data['issued_amount'] = issuedAmount;
    data['created_at'] = createdAt;
    data['last_updated'] = lastUpdated;

    return data;
  }

  Item.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data(), snapshot.id);
}
