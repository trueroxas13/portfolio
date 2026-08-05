import 'dart:convert';
import 'dart:io';
import 'book.dart';

String filePath = 'data/catalog_books.json';

class BooksRepo {
  List<Book> books = [];

  BooksRepo(String json){
    final parsedJson = jsonDecode(json);
    parsedJson.forEach((entry) => books.add(Book.fromJson(entry)));
  }

  Book getBook (String name){
    for (var book in books){
      if (book.title == name){
        return book;
      } 
    };
    throw Exception("Book not found!");
  }

  List<Book> getBooksByPageCount (int pageCount){
    return books.where((a) => a.pageCount >= pageCount).toList();
  }

  List<Book> getBooksByCategory (String category) {
    return books.where((a) => a.category == category).toList();
  }

  Map<String, int> getAuthorsBookCount(){
    List<String> authors = [];

    for (var book in books){
      for (var author in book.authors){
        if (!authors.contains(author)){
          authors.add(author);
        }
      }
    }

    List<int> count = [];
    int counter = 0;

    for (var author in authors){  
      for (var book in books){
        if (book.authors.contains(author)){
          counter++;
        }
      }
      count.add(counter);
      counter = 0;
    }
    
    Map<String, int> authorsToBooks = Map.fromIterables(authors, count);
    
    return authorsToBooks;
  }
}
 
extension on List<Book>{
    filterByAuthor(String author) => this.where((a)=>a.authors.contains(author)).toList();
    filterByCategory(String category) => this.where((a)=>a.category == category).toList();
}

void main(List<String> Args){
  var file = File(filePath);
  var jsonString = file.readAsStringSync();

  BooksRepo repo = new BooksRepo(jsonString);

  print("the repo has loaded the following information: \n${repo.books}");

  print("getting the book named \"Flex 3 in Action\": \n${repo.getBook("Flex 3 in Action")}");

  print("the following books have pages equal to or greater than 400: \n${repo.getBooksByPageCount(400)}");
  
  print("the following books belong to the Java category: \n${repo.getBooksByCategory("Java")}");

  print("Authors with their respective book count: \n${repo.getAuthorsBookCount()}");

  print("The following books were written by the author \"Rob Allen\": \n${repo.books.filterByAuthor("Rob Allen")}");

  print("The following books belong to the \"Web Development\" category: \n${repo.books.filterByCategory("Web Development")}");
 }