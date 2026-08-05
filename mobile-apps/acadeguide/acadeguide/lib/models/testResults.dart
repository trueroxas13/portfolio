import 'dart:convert';

import 'package:acadeguide/models/major.dart';

class Testresults {
  int? id;
  String? userId;
  List<Majors>? recommendedMajors;
  DateTime? date_time;

  Testresults({
    this.id,
    this.userId,
    this.recommendedMajors,
    this.date_time,
  });

  factory Testresults.fromJson(Map<String, dynamic> json) {
    List<Majors>? recommendedMajors;

    final decoded = jsonDecode(json['recommendedMajors']);
    recommendedMajors =
        (decoded as List).map((major) => Majors.fromJson(major)).toList();

    return Testresults(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      recommendedMajors: recommendedMajors,
      date_time: json['date_time'] != null
          ? DateTime.parse(json['date_time'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'recommendedMajors':
          recommendedMajors?.map((major) => major.toJson()).toList(),
      'date_time': date_time?.toIso8601String(),
    };
  }
}
