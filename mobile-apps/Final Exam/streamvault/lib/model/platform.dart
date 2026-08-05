import 'package:floor/floor.dart';

@Entity(
  tableName: 'platform'
)
class Platform {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String country;
  final int activeUsers;
  final int monthlyCost;
  final String logoUrl;

  Platform({
    required this.id,
    required this.name,
    required this.country,
    required this.activeUsers,
    required this.monthlyCost,
    required this.logoUrl,
  });
}
