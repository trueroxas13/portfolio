import 'package:floor/floor.dart';

@Entity(
  tableName: 'category'
)
class Category {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String category;

  Category({
    this.id, 
    required this.category,
  });
}