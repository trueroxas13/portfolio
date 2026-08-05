
import 'package:floor/floor.dart';

@DatabaseView(
  '''
  SELECT p.id as platformId, p.name as platformName,
    COUNT(*) AS totalMovies,
    AVG(rating) AS averageRating, 
    AVG(duration) AS averageDuration
    FROM platform p
    LEFT JOIN movie m ON p.id = m.platformId
  GROUP BY p.id
''', viewName: 'PlatformSummaryView'
)
class PlatformSummaryView {
  final int platformId;
  final String platformName;
  final int totalMovies;
  final double averageRating;
  final double averageDuration;

  PlatformSummaryView(
    this.platformId,
    this.platformName,
    this.totalMovies,
    this.averageRating,
    this.averageDuration,
  );
}
