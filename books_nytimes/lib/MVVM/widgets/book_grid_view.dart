import 'package:books_nytimes/MVVM/models/book_model.dart';
import 'package:books_nytimes/MVVM/utils/constants.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_list_view_model.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'circle_image.dart';

class BookGridStateless extends StatelessWidget {
  final List<BookViewModel> books;

  const BookGridStateless({Key key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BookGrid(
      books: books,
    );
  }
}

class BookGrid extends StatefulWidget {
  final List<BookViewModel> books;

  const BookGrid({Key key, this.books}) : super(key: key);

  @override
  _BookGridState createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75 * Constants.heightBlockSize,
      width: 95 * Constants.widthBlockSize,
      child: GridView.builder(
        itemCount: widget.books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 2
                    : 3),
        itemBuilder: (BuildContext _, int index) {
          final book = widget.books[index];

          return GestureDetector(
            onTap: () {
              //_showNewsArticleDetails(context, article);
            },
            child: GridTile(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: CircleImage(
                  imageUrl: book.imageUrl,
                ),
              ),
              footer: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                child: Text(
                  book.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
//  @override
//  void initState() {
//    super.initState();
//    Provider.of<BookListViewModel>(context, listen: false)
//        .fetchedCurrentBooks(widget.bookType);
//  }

//  @override
//  Widget build(BuildContext context) {
//    var bookListViewModel = Provider.of<BookListViewModel>(context);
//    return _buildList(bookListViewModel);
//  }
//
//  List<BookViewModel> updateBooks(String currentValue) {
//    Provider.of<BookListViewModel>(context, listen: false)
//        .fetchedCurrentBooks(currentValue);
//    return Provider.of<BookListViewModel>(context).books;
//  }
//
//  Widget _buildList(BookListViewModel bookListViewModel) {
//    switch (bookListViewModel.loadingStatus) {
//      case CategoryLoadingStatus.loading:
//        return Center(
//          child: CircularProgressIndicator(),
//        );
//      case CategoryLoadingStatus.completed:
//        var currentBooksList = Provider.of<BookListViewModel>(context).books;
//        return Container(
//          height: 75 * Constants.heightBlockSize,
//          width: 95 * Constants.widthBlockSize,
//          child: GridView.builder(
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: 2,
//            ),
//            itemBuilder: (context, index) {
//              return Text(currentBooksList[index].title);
//            },
//            itemCount: currentBooksList.length,
//          ),
//        );
//
//      case CategoryLoadingStatus.empty:
//      default:
//        return Center(
//          child: Text("No results found"),
//        );
//    }
//  }

}
