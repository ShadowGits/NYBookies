import 'package:books_nytimes/MVVM/models/book_type_model.dart';

class BookTypeViewModel {
  BookType _bookType;

  BookTypeViewModel({BookType bookType}) : _bookType = bookType;

  String get category {
    return _bookType.category;
  }
}
