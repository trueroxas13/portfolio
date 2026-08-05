import 'package:floor/floor.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';

@Entity(
  tableName: 'cartItem',
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
class CartItem{
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String productId;
  final String userId;
  final String title, imageUrl, category, description;
  final double unitPrice;

  get assetImageUrl => "assets/images/$imageUrl";

  int quantity;
  CartItem({
    this.id,
    required this.productId,
    required this.userId,
    required this.title,
    required this.unitPrice,
    required this.quantity,
    required this.imageUrl,
    required this.category,
    required this.description,
  });

  CartItem.empty()
      : id = 0,
        productId= "",
        userId = "",
        title = "",
        unitPrice = 0,
        quantity = 0,
        imageUrl = "",
        category = "",
        description = "";

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      userId: json['userId'],
      title: json['title'],
      unitPrice: json['price'],
      quantity: json['quantity'],
      imageUrl: json['imageName'],
      category: json['category'],
      description: json['description'],

    );
  }

  CartItem copyWith({
    int? id,
    String? productId,
    String? userId,
    String? title,
    double? unitPrice,
    int? quantity,
    String? imageUrl,
    String? category,
    String? description,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  calculateTotalPrice() => unitPrice * quantity;
}
