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

  ProductDao? _productDaoInstance;

  CartItemDao? _cartItemDaoInstance;

  FavoriteDao? _favoriteDaoInstance;

  UserDao? _userDaoInstance;

  CategoryDao? _categoryDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `product` (`id` TEXT NOT NULL, `title` TEXT NOT NULL, `category` TEXT NOT NULL, `description` TEXT NOT NULL, `imageName` TEXT NOT NULL, `price` REAL NOT NULL, `rating` INTEGER NOT NULL, FOREIGN KEY (`category`) REFERENCES `category` (`category`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cartItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `productId` TEXT, `productName` TEXT, `quantity` INTEGER NOT NULL, `userId` TEXT NOT NULL, `unitPrice` REAL NOT NULL, FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorite` (`productId` TEXT NOT NULL, `userId` TEXT NOT NULL, FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`productId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` TEXT NOT NULL, `lastname` TEXT NOT NULL, `firstname` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `profilePic` TEXT NOT NULL, `isAdmin` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `category` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  CartItemDao get cartItemDao {
    return _cartItemDaoInstance ??= _$CartItemDao(database, changeListener);
  }

  @override
  FavoriteDao get favoriteDao {
    return _favoriteDaoInstance ??= _$FavoriteDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'product',
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'category': item.category,
                  'description': item.description,
                  'imageName': item.imageName,
                  'price': item.price,
                  'rating': item.rating
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  @override
  Stream<List<Product>> observeProducts() {
    return _queryAdapter.queryListStream('SELECT * FROM product',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as String,
            title: row['title'] as String,
            category: row['category'] as String,
            description: row['description'] as String,
            imageName: row['imageName'] as String,
            price: row['price'] as double,
            rating: row['rating'] as int),
        queryableName: 'product',
        isView: false);
  }

  @override
  Stream<Product?> getProductById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM product WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as String,
            title: row['title'] as String,
            category: row['category'] as String,
            description: row['description'] as String,
            imageName: row['imageName'] as String,
            price: row['price'] as double,
            rating: row['rating'] as int),
        arguments: [id],
        queryableName: 'product',
        isView: false);
  }

  @override
  Stream<List<Product>> filterProducts(
    String title,
    String category,
  ) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM product WHERE title LIKE ?1 AND IF (category = \'\', TRUE, AND category = ?2)',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as String,
            title: row['title'] as String,
            category: row['category'] as String,
            description: row['description'] as String,
            imageName: row['imageName'] as String,
            price: row['price'] as double,
            rating: row['rating'] as int),
        arguments: [title, category],
        queryableName: 'product',
        isView: false);
  }

  @override
  Future<void> upsertProduct(Product product) async {
    await _productInsertionAdapter.insert(product, OnConflictStrategy.replace);
  }
}

class _$CartItemDao extends CartItemDao {
  _$CartItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _cartItemInsertionAdapter = InsertionAdapter(
            database,
            'cartItem',
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'productName': item.productName,
                  'quantity': item.quantity,
                  'userId': item.userId,
                  'unitPrice': item.unitPrice
                },
            changeListener),
        _cartItemDeletionAdapter = DeletionAdapter(
            database,
            'cartItem',
            ['id'],
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'productName': item.productName,
                  'quantity': item.quantity,
                  'userId': item.userId,
                  'unitPrice': item.unitPrice
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartItem> _cartItemInsertionAdapter;

  final DeletionAdapter<CartItem> _cartItemDeletionAdapter;

  @override
  Stream<List<CartItem>> observeItems(String userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM cartItem WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => CartItem(
            productId: row['productId'] as String?,
            productName: row['productName'] as String?,
            quantity: row['quantity'] as int,
            unitPrice: row['unitPrice'] as double,
            userId: row['userId'] as String),
        arguments: [userId],
        queryableName: 'cartItem',
        isView: false);
  }

  @override
  Future<void> addCartItem(CartItem item) async {
    await _cartItemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> upsertCartItem(CartItem item) async {
    await _cartItemInsertionAdapter.insert(item, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeCartItem(CartItem item) async {
    await _cartItemDeletionAdapter.delete(item);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _favoriteInsertionAdapter = InsertionAdapter(
            database,
            'favorite',
            (Favorite item) => <String, Object?>{
                  'productId': item.productId,
                  'userId': item.userId
                },
            changeListener),
        _favoriteDeletionAdapter = DeletionAdapter(
            database,
            'favorite',
            ['productId'],
            (Favorite item) => <String, Object?>{
                  'productId': item.productId,
                  'userId': item.userId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Favorite> _favoriteInsertionAdapter;

  final DeletionAdapter<Favorite> _favoriteDeletionAdapter;

  @override
  Stream<List<Favorite>> observeFavorites() {
    return _queryAdapter.queryListStream('SELECT * FROM favorite',
        mapper: (Map<String, Object?> row) => Favorite(
            productId: row['productId'] as String,
            userId: row['userId'] as String),
        queryableName: 'favorite',
        isView: false);
  }

  @override
  Stream<List<Favorite>> getUserFavorites(String userId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM favorite WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Favorite(
            productId: row['productId'] as String,
            userId: row['userId'] as String),
        arguments: [userId],
        queryableName: 'favorite',
        isView: false);
  }

  @override
  Future<void> addFavorite(Favorite favorite) async {
    await _favoriteInsertionAdapter.insert(favorite, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeFavorite(Favorite favorite) async {
    await _favoriteDeletionAdapter.delete(favorite);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'lastname': item.lastname,
                  'firstname': item.firstname,
                  'email': item.email,
                  'password': item.password,
                  'profilePic': item.profilePic,
                  'isAdmin': item.isAdmin ? 1 : 0
                },
            changeListener),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'lastname': item.lastname,
                  'firstname': item.firstname,
                  'email': item.email,
                  'password': item.password,
                  'profilePic': item.profilePic,
                  'isAdmin': item.isAdmin ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Stream<User?> getUser(String userId) {
    return _queryAdapter.queryStream('SELECT * FROM user WHERE id = ?1',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as String,
            lastname: row['lastname'] as String,
            firstname: row['firstname'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            profilePic: row['profilePic'] as String,
            isAdmin: (row['isAdmin'] as int) != 0),
        arguments: [userId],
        queryableName: 'user',
        isView: false);
  }

  @override
  Future<void> addUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeUser(User user) async {
    await _userDeletionAdapter.delete(user);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (Category item) =>
                <String, Object?>{'id': item.id, 'category': item.category},
            changeListener),
        _categoryDeletionAdapter = DeletionAdapter(
            database,
            'category',
            ['id'],
            (Category item) =>
                <String, Object?>{'id': item.id, 'category': item.category},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  @override
  Stream<List<Category>> observeCategories() {
    return _queryAdapter.queryListStream('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?, category: row['category'] as String),
        queryableName: 'category',
        isView: false);
  }

  @override
  Future<void> upsertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(
        category, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeCategory(Category category) async {
    await _categoryDeletionAdapter.delete(category);
  }
}
