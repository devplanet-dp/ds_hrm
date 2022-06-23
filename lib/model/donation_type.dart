import 'package:cloud_firestore/cloud_firestore.dart';

enum OrganisationType {CENTRAL_GOVERNMENT, PROVINCIAL_COUNCIL}

class DonationType {
  String? id;
  String? title;
  String? desc;
  OrganisationType? organisation;

  DonationType({this.id, this.title, this.desc, this.organisation});

  DonationType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    organisation = OrganisationType.values[json['organisation']??0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['organisation'] = this.organisation?.index;
    return data;
  }
  DonationType.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data() as Map<String,dynamic>);
}