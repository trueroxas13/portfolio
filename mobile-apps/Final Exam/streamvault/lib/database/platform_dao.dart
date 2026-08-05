import 'package:floor/floor.dart';
import 'package:streamvault/model/platform.dart';
import 'package:streamvault/model/platform_summary_view.dart';

@dao
abstract class PlatformDao {
  @Query("SELECT * FROM platform")
  Stream<List<Platform>> observePlatforms();

  @insert
  Future<void> addPlatform(Platform platform);

  @update
  Future<void> updatePlatform(Platform platform);

  @delete
  Future<void> deletePlatform(Platform platform);

  @Query("SELECT * FROM PlatformSummaryView")
  Stream<PlatformSummaryView?> observePlatformSummaries();

  @Query("SELECT * FROM PlatformSummaryView WHERE platformId = :platformId")
  Stream<PlatformSummaryView?> observePlatformSummary(int platformId);
}
