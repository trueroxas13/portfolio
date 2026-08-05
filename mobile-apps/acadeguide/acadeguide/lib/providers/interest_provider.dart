import 'package:acadeguide/models/interests.dart';
import 'package:acadeguide/repo/appRepo.dart';
import 'package:acadeguide/repo/repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestNotifier extends AsyncNotifier<List<Interests>> {
  late final Apprepo _interestRepo;
  List<Interests> _allInterests = [];

  @override
  Future<List<Interests>> build() async {
    _interestRepo = await ref.watch(appRepoProvider.future);

    List<Interests> interests = await _interestRepo.getInterests();
    if (interests.isEmpty) {
      await _interestRepo.fetchInterests();
      interests = await _interestRepo.getInterests();
    }

    return interests;
  }

  // Future<List<Interests>> initializeInterests() async {
  //   _interestRepo = await ref.watch(appRepoProvider.future);

  //   List<Interests> interests = await _interestRepo.getInterests();
  //   if (interests.isEmpty) {
  //     await _interestRepo.fetchInterests();
  //     interests = await _interestRepo.getInterests();
  //   }
  //   return interests;
  // }
}

final interestNotifierProvider =
    AsyncNotifierProvider<InterestNotifier, List<Interests>>(() {
  return InterestNotifier();
});
