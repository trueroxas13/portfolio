import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streamvault/database/app_database.dart';
import 'package:streamvault/repo/streamvault_repo.dart';

// MoviePalRepoProvider: Provides a future instance of StreamVaultRepository
final streamVaultRepoProvider =
    FutureProvider<StreamVaultRepository>((ref) async {
  //initialize the database here
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    return StreamVaultRepository(platformDao: database.platformDao, movieDao: database.movieDao);
});

// selectedPlatformIdProvider: State provider to track selected platform ID
final selectedPlatformIdProvider = StateProvider<int?>((ref) => null);
