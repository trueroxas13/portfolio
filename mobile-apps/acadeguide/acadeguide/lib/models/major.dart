import 'package:acadeguide/models/list_converter.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'majors',
  primaryKeys: ['majorID'],
)
class Majors {
  String? majorID;
  String? majorName;
  @TypeConverters([StringListConverter])
  List<String>? offeredByUniversity;

  @TypeConverters([StringListConverter])
  List<String>? interests;

  @TypeConverters([StringListConverter])
  List<String>? personalityTraits;

  Majors({
    this.majorID,
    this.majorName,
    this.offeredByUniversity,
    this.interests,
    this.personalityTraits,
  });

  Majors.fromJson(Map<String, dynamic> json) {
    majorID = json['majorID'];
    majorName = json['majorName'];
    offeredByUniversity = List<String>.from(json['offeredByUniversity']);
    interests = List<String>.from(json['interests']);
    personalityTraits = List<String>.from(json['personalityTraits']);
  }

  Map<String, dynamic> toJson() {
    return {
      'majorID': majorID,
      'majorName': majorName,
      'offeredByUniversity': offeredByUniversity,
      'interests': interests,
      'personalityTraits': personalityTraits,
    };
  }
}
