import 'package:books_nytimes/MVVM/models/book_model.dart';
import 'package:books_nytimes/MVVM/models/book_type_model.dart';
import 'package:books_nytimes/MVVM/utils/constants.dart';
import 'package:dio/dio.dart';

class BookApiWebService {
  var dio = Dio();

  Future<List<BookType>> fetchAllBookTypeLists() async {
    final String url = Constants.GET_BOOK_TYPE_LISTS_URL +
        Constants.END_PART_OF_URL +
        Constants.MY_API_KEY_NY_TIMES;
    print(url);

    final response = await dio.get(url);

    if (response.statusCode != 200) {
      return null;
    } else {
      final result = response.data;
      Iterable list = result['results'];
      return list.map(
        (result) {
          return BookType.fromJson(result);
        },
      ).toList();
    }
  }

  Future<List<Book>> fetchSpecificTypeCurrentBookNames(String bookType) async {
    final String url = Constants.GET_BOOK_NAMES_CURRENT_OF_TYPE_URL +
        bookType +
        Constants.END_PART_OF_URL +
        Constants.MY_API_KEY_NY_TIMES;

    print(url);
    final response = await dio.get(url);

    if (response.statusCode != 200) {
      return null;
    } else {
      final result = response.data;
      Iterable listBookData = result['results']['books'];
      return listBookData.map(
        (bookData) {
          //print(bookData);
          Book b = Book.fromJson(bookData);
          return b;
        },
      ).toList();
    }
  }
}
