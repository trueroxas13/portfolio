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

  UniversityDao? _universityDaoInstance;

  MajorDao? _majorDaoInstance;

  InterestDao? _interestDaoInstance;

  TraitsDao? _traitsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `universities` (`uniID` TEXT, `uniName` TEXT, `uniCity` TEXT, `uniCountry` TEXT, `uniLogo` TEXT, `uniWebsite` TEXT, `uniDescription` TEXT, `uniType` TEXT, `uniMajors` TEXT, `tuitionAvg` REAL, PRIMARY KEY (`uniID`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `majors` (`majorID` TEXT, `majorName` TEXT, `offeredByUniversity` TEXT, `interests` TEXT, `personalityTraits` TEXT, PRIMARY KEY (`majorID`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `interests` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `realistic` TEXT, `investigative` TEXT, `artistic` TEXT, `social` TEXT, `enterprising` TEXT, `conventional` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `traits` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `conscientiousness` TEXT, `agreeableness` TEXT, `emotionalStability` TEXT, `extraversion` TEXT, `opennessToExperience` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UniversityDao get universityDao {
    return _universityDaoInstance ??= _$UniversityDao(database, changeListener);
  }

  @override
  MajorDao get majorDao {
    return _majorDaoInstance ??= _$MajorDao(database, changeListener);
  }

  @override
  InterestDao get interestDao {
    return _interestDaoInstance ??= _$InterestDao(database, changeListener);
  }

  @override
  TraitsDao get traitsDao {
    return _traitsDaoInstance ??= _$TraitsDao(database, changeListener);
  }
}

class _$UniversityDao extends UniversityDao {
  _$UniversityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _universityInsertionAdapter = InsertionAdapter(
            database,
            'universities',
            (University item) => <String, Object?>{
                  'uniID': item.uniID,
                  'uniName': item.uniName,
                  'uniCity': item.uniCity,
                  'uniCountry': item.uniCountry,
                  'uniLogo': item.uniLogo,
                  'uniWebsite': item.uniWebsite,
                  'uniDescription': item.uniDescription,
                  'uniType': item.uniType,
                  'uniMajors': _stringListConverter.encode(item.uniMajors),
                  'tuitionAvg': item.tuitionAvg
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<University> _universityInsertionAdapter;

  @override
  Future<List<University>> observeUniversities() async {
    return _queryAdapter.queryList('SELECT * FROM universities',
        mapper: (Map<String, Object?> row) => University(
            uniID: row['uniID'] as String?,
            uniName: row['uniName'] as String?,
            uniCity: row['uniCity'] as String?,
            uniCountry: row['uniCountry'] as String?,
            uniLogo: row['uniLogo'] as String?,
            uniWebsite: row['uniWebsite'] as String?,
            uniDescription: row['uniDescription'] as String?,
            uniType: row['uniType'] as String?,
            uniMajors: _stringListConverter.decode(row['uniMajors'] as String?),
            tuitionAvg: row['tuitionAvg'] as double?));
  }

  @override
  Future<List<String>> getAllMajors() async {
    return _queryAdapter.queryList('SELECT uniMajors FROM universities',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<void> addUniversity(University university) async {
    await _universityInsertionAdapter.insert(
        university, OnConflictStrategy.abort);
  }
}

class _$MajorDao extends MajorDao {
  _$MajorDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _majorsInsertionAdapter = InsertionAdapter(
            database,
            'majors',
            (Majors item) => <String, Object?>{
                  'majorID': item.majorID,
                  'majorName': item.majorName,
                  'offeredByUniversity':
                      _stringListConverter.encode(item.offeredByUniversity),
                  'interests': _stringListConverter.encode(item.interests),
                  'personalityTraits':
                      _stringListConverter.encode(item.personalityTraits)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Majors> _majorsInsertionAdapter;

  @override
  Future<List<Majors>> observeMajors() async {
    return _queryAdapter.queryList('SELECT * FROM majors',
        mapper: (Map<String, Object?> row) => Majors(
            majorID: row['majorID'] as String?,
            majorName: row['majorName'] as String?,
            offeredByUniversity: _stringListConverter
                .decode(row['offeredByUniversity'] as String?),
            interests: _stringListConverter.decode(row['interests'] as String?),
            personalityTraits: _stringListConverter
                .decode(row['personalityTraits'] as String?)));
  }

  @override
  Future<void> addMajor(Majors major) async {
    await _majorsInsertionAdapter.insert(major, OnConflictStrategy.abort);
  }
}

class _$InterestDao extends InterestDao {
  _$InterestDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _interestsInsertionAdapter = InsertionAdapter(
            database,
            'interests',
            (Interests item) => <String, Object?>{
                  'id': item.id,
                  'realistic': _stringListConverter.encode(item.realistic),
                  'investigative':
                      _stringListConverter.encode(item.investigative),
                  'artistic': _stringListConverter.encode(item.artistic),
                  'social': _stringListConverter.encode(item.social),
                  'enterprising':
                      _stringListConverter.encode(item.enterprising),
                  'conventional': _stringListConverter.encode(item.conventional)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Interests> _interestsInsertionAdapter;

  @override
  Future<List<Interests>> observeInterests() async {
    return _queryAdapter.queryList('SELECT * FROM interests',
        mapper: (Map<String, Object?> row) => Interests(
            realistic: _stringListConverter.decode(row['realistic'] as String?),
            investigative:
                _stringListConverter.decode(row['investigative'] as String?),
            artistic: _stringListConverter.decode(row['artistic'] as String?),
            social: _stringListConverter.decode(row['social'] as String?),
            enterprising:
                _stringListConverter.decode(row['enterprising'] as String?),
            conventional:
                _stringListConverter.decode(row['conventional'] as String?)));
  }

  @override
  Future<int> addInterest(Interests interest) {
    return _interestsInsertionAdapter.insertAndReturnId(
        interest, OnConflictStrategy.abort);
  }
}

class _$TraitsDao extends TraitsDao {
  _$TraitsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _traitsInsertionAdapter = InsertionAdapter(
            database,
            'traits',
            (Traits item) => <String, Object?>{
                  'id': item.id,
                  'conscientiousness':
                      _stringListConverter.encode(item.conscientiousness),
                  'agreeableness':
                      _stringListConverter.encode(item.agreeableness),
                  'emotionalStability':
                      _stringListConverter.encode(item.emotionalStability),
                  'extraversion':
                      _stringListConverter.encode(item.extraversion),
                  'opennessToExperience':
                      _stringListConverter.encode(item.opennessToExperience)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Traits> _traitsInsertionAdapter;

  @override
  Future<List<Traits>> observeTraits() async {
    return _queryAdapter.queryList('SELECT * FROM traits',
        mapper: (Map<String, Object?> row) => Traits(
            conscientiousness: _stringListConverter
                .decode(row['conscientiousness'] as String?),
            agreeableness:
                _stringListConverter.decode(row['agreeableness'] as String?),
            emotionalStability: _stringListConverter
                .decode(row['emotionalStability'] as String?),
            extraversion:
                _stringListConverter.decode(row['extraversion'] as String?),
            opennessToExperience: _stringListConverter
                .decode(row['opennessToExperience'] as String?)));
  }

  @override
  Future<int> addTrait(Traits trait) {
    return _traitsInsertionAdapter.insertAndReturnId(
        trait, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();
