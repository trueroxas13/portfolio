import 'package:acadeguide/models/list_converter.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'universities', primaryKeys: ['uniID'])
class University {
  String? uniID;
  String? uniName;
  String? uniCity;
  String? uniCountry;
  String? uniLogo;
  String? uniWebsite;
  String? uniDescription;
  String? uniType;

  @TypeConverters([StringListConverter])
  List<String>? uniMajors;

  double? tuitionAvg;

  University({
    this.uniID,
    this.uniName,
    this.uniCity,
    this.uniCountry,
    this.uniLogo,
    this.uniWebsite,
    this.uniDescription,
    this.uniType,
    this.uniMajors,
    this.tuitionAvg,
  });

  University.fromJson(Map<String, dynamic> json) {
    uniID = json['uniID'];
    uniName = json['uniName'];
    uniCity = json['uniCity'];
    uniCountry = json['uniCountry'];
    uniLogo = json['uniLogo'];
    uniWebsite = json['uniWebsite'];
    uniDescription = json['uniDescription'];
    uniType = json['uniType'];
    uniMajors = List<String>.from(json['uniMajors']);
    tuitionAvg = json['tuitionAvg']?.toDouble();
  }
}
