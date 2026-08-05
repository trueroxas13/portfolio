import 'package:floor/floor.dart';
import 'package:streamvault/model/movie.dart';

@dao
abstract class MovieDao {
  @Query("SELECT * FROM movie WHERE platformId = :platformId")
  Stream<List<Movie>> observeMovies(int platformId);
  @insert
  Future<void> addMovie(Movie movie);
  @update
  Future<void> updateMovie(Movie movie);
  @delete
  Future<void> deleteMovie(Movie movie);
  @Query("SELECT * FROM movie WHERE id = :id")
  Future<Movie?> getMovieById(int id);
}