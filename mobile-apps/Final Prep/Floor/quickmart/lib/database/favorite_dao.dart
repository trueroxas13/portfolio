import 'package:floor/floor.dart';
import 'package:quickmart/models/favorite.dart';

@dao
abstract class FavoriteDao {

  @Query("SELECT * FROM favorite")
  Stream<List<Favorite>> observeFavorites();

  @insert
  Future<void> addFavorite(Favorite favorite);

  @delete
  Future<void> removeFavorite(Favorite favorite);

  @Query("SELECT * FROM favorite WHERE userId = :userId")
  Stream<List<Favorite>> getUserFavorites(String userId);

}