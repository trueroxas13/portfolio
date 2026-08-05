import 'package:acadeguide/models/list_converter.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "traits")
class Traits {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @TypeConverters([StringListConverter])
  List<String>? conscientiousness;
  @TypeConverters([StringListConverter])
  List<String>? agreeableness;
  @TypeConverters([StringListConverter])
  List<String>? emotionalStability;
  @TypeConverters([StringListConverter])
  List<String>? extraversion;
  @TypeConverters([StringListConverter])
  List<String>? opennessToExperience;

  Traits(
      {this.conscientiousness,
      this.agreeableness,
      this.emotionalStability,
      this.extraversion,
      this.opennessToExperience});

  Traits.fromJson(Map<String, dynamic> json) {
    conscientiousness = List<String>.from(json["Conscientiousness"]);
    agreeableness = List<String>.from(json["Agreeableness"]);
    emotionalStability = List<String>.from(json["Emotional Stability"]);
    extraversion = List<String>.from(json["Extraversion"]);
    opennessToExperience = List<String>.from(json["Openness to Experience"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "Conscientiousness": conscientiousness,
      "Agreeableness": agreeableness,
      "Emotional Stability": emotionalStability,
      "Extraversion": extraversion,
      "Openness to Experience": opennessToExperience,
    };
  }
}
