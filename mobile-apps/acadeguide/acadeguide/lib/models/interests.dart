import 'package:acadeguide/models/list_converter.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "interests")
class Interests {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @TypeConverters([StringListConverter])
  List<String>? realistic;
  @TypeConverters([StringListConverter])
  List<String>? investigative;
  @TypeConverters([StringListConverter])
  List<String>? artistic;
  @TypeConverters([StringListConverter])
  List<String>? social;
  @TypeConverters([StringListConverter])
  List<String>? enterprising;
  @TypeConverters([StringListConverter])
  List<String>? conventional;

  Interests(
      {this.realistic,
      this.investigative,
      this.artistic,
      this.social,
      this.enterprising,
      this.conventional});

  Interests.fromJson(Map<String, dynamic> json) {
    realistic = List<String>.from(json["Realistic"]);
    investigative = List<String>.from(json["Investigative"]);
    artistic = List<String>.from(json["Artistic"]);
    social = List<String>.from(json["Social"]);
    enterprising = List<String>.from(json["Enterprising"]);
    conventional = List<String>.from(json["Conventional"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "Realistic": realistic,
      "Investigative": investigative,
      "Artistic": artistic,
      "Social": social,
      "Enterprising": enterprising,
      "Conventional": conventional,
    };
  }
}
