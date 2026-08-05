import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streamvault/model/movie.dart';
import 'package:streamvault/providers/streamvault_repo_provider.dart';
import 'package:streamvault/repo/streamvault_repo.dart';

class MovieNotifier extends AsyncNotifier<List<Movie>> {
  StreamVaultRepository? _repository;

  @override
  Future<List<Movie>> build() async {
    _repository = await ref.watch(streamVaultRepoProvider.future);
    final platformId = ref.watch(selectedPlatformIdProvider);

    _repository?.observeMovies(platformId!).listen((movies) {
      state = AsyncData(movies);
    });
    return [];
  }

  void addMovie(Movie movie) async {
    await _repository?.addMovie(movie);
  }

  void updateMovie(Movie movie) async {
    await _repository?.updateMovie(movie);
  }

  void deleteMovie(Movie movie) async {
    try {
      await _repository?.deleteMovie(movie);
    } catch (e) {
      print(e);
    }
  }
}

final movieNotifierProvider =
    AsyncNotifierProvider<MovieNotifier, List<Movie>>(() => MovieNotifier());
