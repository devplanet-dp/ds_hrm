import 'package:cloud_firestore/cloud_firestore.dart';

enum CourseType { Degree, Diploma, Other }

class Education {
  late String institution;
  late String name;
  late String year;
  late String desc;
  late String id;
  late CourseType courseType;

  Education(
      {required this.institution,
      required this.name,
      required this.year,
      required this.desc,
      required this.courseType,
      required this.id});

  Education.fromMap(Map<String, dynamic>? json) {
    institution = json!['institution'];
    name = json['name'];
    year = json['year'];
    desc = json['desc'];
    courseType = CourseType.values.elementAt(json['course_type'] ?? 1);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['institution'] = this.institution;
    data['name'] = this.name;
    data['course_type'] = this.courseType.index;
    data['year'] = this.year;
    data['desc'] = this.desc;
    data['id'] = this.id;
    return data;
  }

  Education.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>?);
}
