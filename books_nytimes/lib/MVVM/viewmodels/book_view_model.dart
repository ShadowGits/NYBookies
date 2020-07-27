import 'package:books_nytimes/MVVM/models/book_model.dart';

class BookViewModel {
  Book _book;

  BookViewModel({Book book}) : _book = book;

  int get rank => _book.rank;

  String get primaryISBN => _book.primaryISBN;

  String get publisher => _book.publisher;

  String get title => _book.title;

  String get description => _book.description;

  String get author => _book.author;

  String get imageUrl => _book.imageUrl;
}
