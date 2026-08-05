import 'package:floor/floor.dart';
import 'package:streamvault/model/platform.dart';

@Entity(
  tableName: 'movie',
  foreignKeys: [
    ForeignKey(
      childColumns: ['platformId'],
      parentColumns: ['id'],
      entity: Platform,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade
    )
  ]
)
class Movie {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String director;
  final String releaseYear;
  final int rating;
  final int duration;
  final String posterUrl;
  final int platformId;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.releaseYear,
    required this.rating,
    required this.duration,
    required this.posterUrl,
    required this.platformId,
  });
}
