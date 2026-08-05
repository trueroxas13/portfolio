import 'package:floor/floor.dart';
import 'package:yalla_pay/model/user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users')
  Stream<List<User>> observeUser();

  @insert
  Future<void> addUser(User user);

  @delete
  Future<void> deleteUser(User user);

  @update
  Future<void> updateUser(User user);
}