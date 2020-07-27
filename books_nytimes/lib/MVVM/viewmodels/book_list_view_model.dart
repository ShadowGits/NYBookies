import 'package:books_nytimes/MVVM/models/book_model.dart';
import 'package:books_nytimes/MVVM/models/book_type_model.dart';
import 'package:books_nytimes/MVVM/services/book_api_service.dart';
import 'package:books_nytimes/MVVM/utils/constants.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_type_view_model.dart';
import 'package:flutter/material.dart';

import 'book_view_model.dart';

class BookListViewModel with ChangeNotifier {
  CategoryLoadingStatus loadingStatusBookType = CategoryLoadingStatus.loading;
  CategoryLoadingStatus loadingStatusBookData = CategoryLoadingStatus.loading;

  List<BookViewModel> books = List<BookViewModel>();
  List<BookTypeViewModel> types = List<BookTypeViewModel>();

  void fetchedCurrentBooks(String bookType) async {
    try {
      List<Book> books =
          await BookApiWebService().fetchSpecificTypeCurrentBookNames(bookType);
      loadingStatusBookData = CategoryLoadingStatus.loading;
      notifyListeners();

      this.books = books.map((book) => BookViewModel(book: book)).toList();

      if (this.books.isEmpty) {
        loadingStatusBookData = CategoryLoadingStatus.loading;
      } else {
        loadingStatusBookData = CategoryLoadingStatus.completed;
      }
      notifyListeners();
    } on Exception catch (e) {
      loadingStatusBookData = CategoryLoadingStatus.empty;
    }
  }

  void updatedBookCategories() async {
    try {
      List<BookType> bookTypes =
          await BookApiWebService().fetchAllBookTypeLists();
      loadingStatusBookType = CategoryLoadingStatus.loading;
      notifyListeners();

      this.types = bookTypes
          .map((bookType) => BookTypeViewModel(bookType: bookType))
          .toList();

      if (this.types.isEmpty) {
        loadingStatusBookType = CategoryLoadingStatus.loading;
      } else {
        loadingStatusBookType = CategoryLoadingStatus.completed;
      }
      notifyListeners();
    } on Exception catch (e) {
      loadingStatusBookType = CategoryLoadingStatus.empty;
    }
  }
}
