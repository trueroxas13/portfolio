import 'package:acadeguide/models/traits.dart';
import 'package:acadeguide/repo/appRepo.dart';
import 'package:acadeguide/repo/repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TraitsNotifier extends AsyncNotifier<List<Traits>> {
  late final Apprepo _traitsRepo;
  List<Traits> _allTraits = [];

  @override
  @override
  Future<List<Traits>> build() async {
    _traitsRepo = await ref.watch(appRepoProvider.future);

    List<Traits> traits = await _traitsRepo.getTraits();
    if (traits.isEmpty) {
      await _traitsRepo.fetchTraits();
      traits = await _traitsRepo.getTraits();
    }

    return traits;
  }

  // Future<List<Traits>> initializeTraits() async {
  //   _traitsRepo = await ref.watch(appRepoProvider.future);

  //   List<Traits> traits = await _traitsRepo.getTraits();
  //   if (traits.isEmpty) {
  //     await _traitsRepo.fetchTraits();
  //     traits = await _traitsRepo.getTraits();
  //   }

  //   return traits;
  //   ;
  // }
}

final traitsNotifierProvider =
    AsyncNotifierProvider<TraitsNotifier, List<Traits>>(() {
  return TraitsNotifier();
});
