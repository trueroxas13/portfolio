import 'package:floor/floor.dart';
import 'package:quickmart/models/user.dart';

@dao
abstract class UserDao {
  @Query("SELECT * FROM user WHERE id = :userId")
  Stream<User?> getUser(String userId);

  @insert
  Future<void> addUser(User user);

  @delete
  Future<void> removeUser(User user);
}