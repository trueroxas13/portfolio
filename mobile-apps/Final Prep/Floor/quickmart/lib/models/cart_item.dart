import 'package:floor/floor.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';

@Entity(
  tableName: 'cartItem',
  foreignKeys: [
    ForeignKey(
      childColumns: ['productId'], 
      parentColumns: ['id'], 
      entity: Product
    ),
    ForeignKey(
      childColumns: ['userId'], 
      parentColumns: ['id'], 
      entity: User
    ),
  ]
)
class CartItem {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? productId, productName;
  int quantity;
  String userId;
  double unitPrice;

  CartItem({
    required this.productId,
    this.productName,
    this.quantity = 0,
    this.unitPrice = 0,
    required this.userId
  });
}