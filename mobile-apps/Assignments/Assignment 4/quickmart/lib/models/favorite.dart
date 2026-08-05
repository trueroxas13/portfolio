import 'package:floor/floor.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';

@Entity(
  tableName: 'favorite',
  foreignKeys: [
    ForeignKey(
      childColumns: ['productId'],
      parentColumns: ['id'],
      entity: Product,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade
    ),
    ForeignKey(
      childColumns: ['userId'],
      parentColumns: ['id'],
      entity: User,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade
    ),
  ]
)
class Favorite  {
  @PrimaryKey()
  String? id;

  final String productId, userId;

  Favorite({
    this.id,
    required this.productId,
    required this.userId
  });

  factory Favorite.fromJson(Map<String,dynamic> json){
    return Favorite(
      id: json['id'] as String,
      productId: json['productId'] as String,
      userId: json['userId'] as String
    );
  }

  Map<String, dynamic> toJson (){
    return {
      'id' : id,
      'productId' : productId,
      'userId' : userId
    };
  }
}