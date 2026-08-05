class Product {
  String id, title, category, description, imageName;
  double price;
  int rating;
  
  Product ({required this.id, required this.title, required this.category, required this.description, required this.imageName, required this.price, required this.rating});

  factory Product.fromJSON(Map<String, dynamic> map){
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      imageName: map['imageName'] as String,
      price: map['price'] as double,
      rating: map['rating'] as int
    );
  }
}