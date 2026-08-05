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
class Favorite {
  @primaryKey
  String productId;
  
  @primaryKey
  String userId;

  Favorite ({
    required this.productId,
    required this.userId
  });
}