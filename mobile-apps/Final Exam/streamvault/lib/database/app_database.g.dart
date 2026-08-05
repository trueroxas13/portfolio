// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  PlatformDao? _platformDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movie` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `director` TEXT NOT NULL, `releaseYear` TEXT NOT NULL, `rating` INTEGER NOT NULL, `duration` INTEGER NOT NULL, `posterUrl` TEXT NOT NULL, `platformId` INTEGER NOT NULL, FOREIGN KEY (`platformId`) REFERENCES `platform` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `platform` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `country` TEXT NOT NULL, `activeUsers` INTEGER NOT NULL, `monthlyCost` INTEGER NOT NULL, `logoUrl` TEXT NOT NULL)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `PlatformSummaryView` AS   SELECT p.id as platformId, p.name as platformName,\n    COUNT(*) AS totalMovies,\n    AVG(rating) AS averageRating, \n    AVG(duration) AS averageDuration\n    FROM platform p\n    LEFT JOIN movie m ON p.id = m.platformId\n  GROUP BY p.id\n');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  PlatformDao get platformDao {
    return _platformDaoInstance ??= _$PlatformDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'director': item.director,
                  'releaseYear': item.releaseYear,
                  'rating': item.rating,
                  'duration': item.duration,
                  'posterUrl': item.posterUrl,
                  'platformId': item.platformId
                },
            changeListener),
        _movieUpdateAdapter = UpdateAdapter(
            database,
            'movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'director': item.director,
                  'releaseYear': item.releaseYear,
                  'rating': item.rating,
                  'duration': item.duration,
                  'posterUrl': item.posterUrl,
                  'platformId': item.platformId
                },
            changeListener),
        _movieDeletionAdapter = DeletionAdapter(
            database,
            'movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'director': item.director,
                  'releaseYear': item.releaseYear,
                  'rating': item.rating,
                  'duration': item.duration,
                  'posterUrl': item.posterUrl,
                  'platformId': item.platformId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  final UpdateAdapter<Movie> _movieUpdateAdapter;

  final DeletionAdapter<Movie> _movieDeletionAdapter;

  @override
  Stream<List<Movie>> observeMovies(int platformId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM movie WHERE platformId = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int?,
            title: row['title'] as String,
            director: row['director'] as String,
            releaseYear: row['releaseYear'] as String,
            rating: row['rating'] as int,
            duration: row['duration'] as int,
            posterUrl: row['posterUrl'] as String,
            platformId: row['platformId'] as int),
        arguments: [platformId],
        queryableName: 'movie',
        isView: false);
  }

  @override
  Future<Movie?> getMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM movie WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int?,
            title: row['title'] as String,
            director: row['director'] as String,
            releaseYear: row['releaseYear'] as String,
            rating: row['rating'] as int,
            duration: row['duration'] as int,
            posterUrl: row['posterUrl'] as String,
            platformId: row['platformId'] as int),
        arguments: [id]);
  }

  @override
  Future<void> addMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMovie(Movie movie) async {
    await _movieUpdateAdapter.update(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(Movie movie) async {
    await _movieDeletionAdapter.delete(movie);
  }
}

class _$PlatformDao extends PlatformDao {
  _$PlatformDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _platformInsertionAdapter = InsertionAdapter(
            database,
            'platform',
            (Platform item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'country': item.country,
                  'activeUsers': item.activeUsers,
                  'monthlyCost': item.monthlyCost,
                  'logoUrl': item.logoUrl
                },
            changeListener),
        _platformUpdateAdapter = UpdateAdapter(
            database,
            'platform',
            ['id'],
            (Platform item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'country': item.country,
                  'activeUsers': item.activeUsers,
                  'monthlyCost': item.monthlyCost,
                  'logoUrl': item.logoUrl
                },
            changeListener),
        _platformDeletionAdapter = DeletionAdapter(
            database,
            'platform',
            ['id'],
            (Platform item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'country': item.country,
                  'activeUsers': item.activeUsers,
                  'monthlyCost': item.monthlyCost,
                  'logoUrl': item.logoUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Platform> _platformInsertionAdapter;

  final UpdateAdapter<Platform> _platformUpdateAdapter;

  final DeletionAdapter<Platform> _platformDeletionAdapter;

  @override
  Stream<List<Platform>> observePlatforms() {
    return _queryAdapter.queryListStream('SELECT * FROM platform',
        mapper: (Map<String, Object?> row) => Platform(
            id: row['id'] as int?,
            name: row['name'] as String,
            country: row['country'] as String,
            activeUsers: row['activeUsers'] as int,
            monthlyCost: row['monthlyCost'] as int,
            logoUrl: row['logoUrl'] as String),
        queryableName: 'platform',
        isView: false);
  }

  @override
  Stream<PlatformSummaryView?> observePlatformSummaries() {
    return _queryAdapter.queryStream('SELECT * FROM PlatformSummaryView',
        mapper: (Map<String, Object?> row) => PlatformSummaryView(
            row['platformId'] as int,
            row['platformName'] as String,
            row['totalMovies'] as int,
            row['averageRating'] as double,
            row['averageDuration'] as double),
        queryableName: 'PlatformSummaryView',
        isView: true);
  }

  @override
  Stream<PlatformSummaryView?> observePlatformSummary(int platformId) {
    return _queryAdapter.queryStream(
        'SELECT * FROM PlatformSummaryView WHERE platformId = ?1',
        mapper: (Map<String, Object?> row) => PlatformSummaryView(
            row['platformId'] as int,
            row['platformName'] as String,
            row['totalMovies'] as int,
            row['averageRating'] as double,
            row['averageDuration'] as double),
        arguments: [platformId],
        queryableName: 'PlatformSummaryView',
        isView: true);
  }

  @override
  Future<void> addPlatform(Platform platform) async {
    await _platformInsertionAdapter.insert(platform, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePlatform(Platform platform) async {
    await _platformUpdateAdapter.update(platform, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePlatform(Platform platform) async {
    await _platformDeletionAdapter.delete(platform);
  }
}
