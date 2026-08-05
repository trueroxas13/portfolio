import 'package:floor/floor.dart';

@Entity(
  tableName: 'user',
)
class User {
  @primaryKey
  String id;
  String lastname, firstname, email, password, profilePic;

  bool isAdmin;

  User ({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.isAdmin
  });

  factory User.defaultUser(){
    return User(
      id: 'default',
      lastname: 'doe',
      firstname: 'john',
      email: 'john@doe.com',
      password: 'johndoe',
      profilePic: '',
      isAdmin: true
    );
  }
}