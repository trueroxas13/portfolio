import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streamvault/model/platform_summary_view.dart';
import 'package:streamvault/model/platform.dart';
import 'package:streamvault/providers/streamvault_repo_provider.dart';
import 'package:streamvault/repo/streamvault_repo.dart';

class PlatformNotifier extends AsyncNotifier<List<Platform>> {
  late final StreamVaultRepository _repository;

  @override
  Future<List<Platform>> build() async {
    _repository = await ref.watch(streamVaultRepoProvider.future);
    _repository.initializeDatabase();
    _repository.observePlatforms().listen((platforms) {
      state = AsyncData(platforms);
    });
    return []; // Initial empty state
  }

  void addPlatform(Platform platform) async {
    await _repository.addPlatform(platform);
  }

  void updatePlatform(Platform platform) async {
    await _repository.updatePlatform(platform);
  }

  void deletePlatform(Platform platform) async {
    try {
      await _repository.deletePlatform(platform);
    } catch (e) {
      print(e);
    }
  }

  Stream<PlatformSummaryView?> observePlatformSummary(int platformId) {
    return _repository.observePlatformSummary(platformId);
  }
}

final platformNotifierProvider =
    AsyncNotifierProvider<PlatformNotifier, List<Platform>>(
        () => PlatformNotifier());
