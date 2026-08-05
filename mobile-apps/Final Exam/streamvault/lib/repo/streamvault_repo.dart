import 'package:dio/dio.dart';
import 'package:streamvault/database/platform_dao.dart';
import 'package:streamvault/database/movie_dao.dart';
import 'package:streamvault/model/platform.dart';

import 'package:streamvault/model/movie.dart';
import 'package:streamvault/model/platform_summary_view.dart';

class StreamVaultRepository {
  final PlatformDao platformDao;
  final MovieDao movieDao;
  final String _platformUrl = 'https://api-8t7c.onrender.com/platforms';
  final String _movieUrl = 'https://api-8t7c.onrender.com/movies';
  final Dio _dio = Dio();

  StreamVaultRepository({required this.platformDao, required this.movieDao});

  // Initialize the database from web API
  /// Initialize the database only if it is not already initialized
  Future<void> initializeDatabase() async{
    platformDao.observePlatforms().listen((data) async {
      print("hello");
      if (data.isEmpty){
        Response resP = await _dio.get(_platformUrl);
        print(resP.data);
        for(var platformMap in resP.data){
          platformDao.addPlatform(
            Platform(
              id: platformMap['id'],
              name: platformMap['name'],
              country: platformMap['country'],
              activeUsers: platformMap['activeUsers'],
              monthlyCost: platformMap['monthlyCost'],
              logoUrl: platformMap['logoUrl'],
            )
          );
        }

        Response resM = await _dio.get(_movieUrl);
        print(resM.data);
        for(var movieMap in resM.data){
          movieDao.addMovie(
            Movie(
              id: movieMap['id'],
              title: movieMap['title'],
              director: movieMap['director'],
              releaseYear: movieMap['releaseYear'],
              rating: movieMap['rating'],
              duration: movieMap['duration'],
              posterUrl: movieMap['posterUrl'],
              platformId: movieMap['platformId']
            )
          );
        }
      }
    });
  }


  // Platforms
  Stream<List<Platform>> observePlatforms() => platformDao.observePlatforms(); 
  Future<void> addPlatform(Platform platform) => platformDao.addPlatform(platform);
  Future<void> updatePlatform(Platform updatedPlatform) => platformDao.updatePlatform(updatedPlatform);
  Future<void> deletePlatform(Platform platform) => platformDao.deletePlatform(platform);
  Stream<PlatformSummaryView?> observePlatformSummaries() => platformDao.observePlatformSummaries();

  // Movies
  Stream<List<Movie>> observeMovies(int platformId) => movieDao.observeMovies(platformId);
  Future<void> addMovie(Movie movie) => movieDao.addMovie(movie);
  Future<void> updateMovie(Movie movie) => movieDao.updateMovie(movie);
  Future<void> deleteMovie(Movie movie) => movieDao.deleteMovie(movie);
  Future<Movie?> getMovieById(int id) => movieDao.getMovieById(id);
  
  Stream<PlatformSummaryView?> observePlatformSummary(int platformId) => platformDao.observePlatformSummary(platformId);
}
