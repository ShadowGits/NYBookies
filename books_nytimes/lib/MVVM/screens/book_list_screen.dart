import 'package:books_nytimes/MVVM/screens/book_detail_screen.dart';
import 'package:books_nytimes/MVVM/utils/constants.dart';
import 'package:books_nytimes/MVVM/utils/size_config.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_list_view_model.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_type_view_model.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_view_model.dart';
import 'package:books_nytimes/MVVM/widgets/padded_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader/loader.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookListScreen extends StatefulWidget {
  final FirebaseUser user;

  BookListScreen({Key key, @required this.user}) : super(key: key);
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen>
    with LoadingMixin<BookListScreen>, SingleTickerProviderStateMixin {
  BookListViewModel model;
  String selectedCategory;

  List<String> likedIsbns = [];
  Firestore _firestoreInstance;
  DocumentReference documentRef;

  @override
  void initState() {
    _firestoreInstance = Firestore.instance;
    documentRef =
        _firestoreInstance.collection("users").document(widget.user.email);

    super.initState();
    model = Provider.of<BookListViewModel>(context, listen: false);
    model.updatedBookCategories();

    print("fetching categories initiated");
  }

  SharedPreferences preferences;
  Map<String, String> urlNameMap;
  List<BookTypeViewModel> itemList;
  List<String> itemNames = [];
  List<BookViewModel> books = [];

  Widget _buildList(BookListViewModel bookTypeListViewModel) {
    switch (bookTypeListViewModel.loadingStatusBookType) {
      case CategoryLoadingStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case CategoryLoadingStatus.completed:
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellowAccent,
              title: Text(
                "NYBookies",
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.category),
                  onPressed: () {
                    getCategorySelected();
                  },
                  color: Colors.black,
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 3),
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topRight: Constants.borderRadiusNameCard,
                          bottomLeft: Constants.borderRadiusNameCard,
                          bottomRight: Constants.borderRadiusNameCard),
                    ),
                    height: 7 * Constants.heightBlockSize,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 2 * Constants.widthBlockSize,
                        ),
                        Icon(
                          FontAwesomeIcons.theRedYeti,
                          color: Colors.white,
                          size: 38,
                        ),
                        Text(
                          "  ${widget.user.displayName.substring(0, 1).toUpperCase()}${widget.user.displayName.substring(1)}   ",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 2 * Constants.heightBlockSize,
                ),
                SizedBox(
                  height: Constants.heightBlockSize * 1,
                ),
                _buildBookGrid(model),
              ],
            ),
          ),
        );
      case CategoryLoadingStatus.empty:
      default:
        return Center(
          child: Text("No results found"),
        );
    }
  }

  Widget _buildBookGrid(BookListViewModel model) {
    switch (model.loadingStatusBookData) {
      case CategoryLoadingStatus.loading:
        return Center(child: CircularProgressIndicator());

      case CategoryLoadingStatus.completed:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedCategory.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.w800, color: Colors.brown),
              ),
            ),
            Container(
              height: 70 * Constants.heightBlockSize,
              width: 100 * Constants.widthBlockSize,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: likedIsbns.contains(books[index].primaryISBN)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () async {
                            String isbn = books[index].primaryISBN;
                            if (likedIsbns.contains(isbn)) {
                              likedIsbns.remove(isbn);
                            } else {
                              likedIsbns.add(isbn);
                            }
                            _firestoreInstance
                                .runTransaction((transaction) async {
                              transaction.update(
                                  documentRef, {"liked_isbns": likedIsbns});
                            });
                            setState(() {});
                          }
//                          setState(() {
//                            if (indexLiked.contains(index)) {
//                              indexLiked.remove(index);
//                            } else {
//                              indexLiked.add(index);
//                            }
//                          });
//                        },
                          ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailScreen(book: books[index]),
                              ),
                            );
                          },
                          child: PaddedCardListTile(
                            book: books[index],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: books.length,
              ),
            ),
          ],
        );
      case CategoryLoadingStatus.empty:
      default:
        return Text("No results available");
    }
  }

  @override
  Widget build(BuildContext context) {
    Constants.heightBlockSize = displaySafeHeightBlocks(context);
    Constants.widthBlockSize = displaySafeWidthBlocks(context);
    var vs = Provider.of<BookListViewModel>(context);

    return _buildList(vs);
  }

  @override
  Future<void> load() async {
    itemList = model.types;
    itemNames = itemList.map((e) => e.category).toList();
    print("still here");
    preferences = await SharedPreferences.getInstance();

    selectedCategory = preferences.getString("bookType") ?? "hardcover-fiction";
    model.fetchedCurrentBooks(selectedCategory);
    books = model.books;

    getLikedIsbnsFireStore();
    print("then here");
  }

  Future<String> getCategorySelected() {
    return SelectDialog.showModal<String>(
      context,
      onChange: (selected) async {
        print(selected);
        await preferences.setString("bookType", selected);

        getLikedIsbnsFireStore();
        setState(() {
          selectedCategory = selected;
          model.loadingStatusBookData = CategoryLoadingStatus.loading;
          model.fetchedCurrentBooks(selectedCategory);
          books = model.books;
        });
      },
      label: "Book Category",
      items: itemNames,
      itemBuilder: (BuildContext context, String category, bool isSelected) {
        return Container(
          height: 10 * Constants.heightBlockSize,
          child: Center(
            child: Text(category),
          ),
          width: 60 * Constants.widthBlockSize,
        );
      },
    );
  }

  void getLikedIsbnsFireStore() async {
    _firestoreInstance.runTransaction((transaction) async {
      var snapshot = await transaction.get(documentRef);
      likedIsbns = List<String>(snapshot.data["liked_isbns"]);
    });
  }
}
