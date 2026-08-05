import 'package:floor/floor.dart';
import 'package:quickmart/models/user.dart';

@dao
abstract class UserDao {
  @Query("SELECT * FROM user")
  Stream<List<User>> observeUsers();

  @delete
  Future<void> deleteUser(User user);

  @insert
  Future<void> addUser(User user);

  @update
  Future<void> updateUser(User user);

}