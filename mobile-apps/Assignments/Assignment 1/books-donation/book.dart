class Book {
  String title, category;
  List<dynamic> authors;
  int pageCount;

  Book ({required this.title, required this.category, required this.authors, required this.pageCount});
  
  factory Book.fromJson(Map<String, dynamic> json){
    return Book(
      title: json['title'] as String,
      category: json['category'] as String,
      authors: json['authors'] as List<dynamic>,
      pageCount: json['pageCount'] as int);
  }

  String toString(){
    return "\n\ntitle: $title, category: $category\nauthors: ${authors}\npage count: ${pageCount}";
  }
}
