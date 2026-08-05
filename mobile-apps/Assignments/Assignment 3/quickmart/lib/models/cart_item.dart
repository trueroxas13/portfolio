class CartItem {
  String? productId, productName;
  int quantity;
  double unitPrice;

  CartItem({
    required this.productId,
    this.productName,
    this.quantity = 0,
    this.unitPrice = 0
  });
}