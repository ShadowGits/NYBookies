import 'package:books_nytimes/MVVM/models/book_model.dart';
import 'package:books_nytimes/MVVM/utils/constants.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_view_model.dart';
import 'package:books_nytimes/MVVM/widgets/circle_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaddedCardListTile extends StatelessWidget {
  final BookViewModel book;
  PaddedCardListTile({this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  "${book.title}",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CircleImage(imageUrl: book.imageUrl),
            ],
          ),
          height: 15 * Constants.heightBlockSize,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
