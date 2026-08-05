import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey()
  final String? id;
  final String firstname,lastname,email,password,profilePic;

  final bool isAdmin;

  User(
    {
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.profilePic,
      required this.isAdmin
    }
  );

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id : json['id'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as bool,
      profilePic: json['profilePic'] as String,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'firstname' : firstname,
      'lastname' : lastname,
      'email' : email,
      'password' : password,
      'isAdmin' : isAdmin,
      'profilePic' : profilePic 
    };
  }

}