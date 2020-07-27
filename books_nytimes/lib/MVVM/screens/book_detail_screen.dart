import 'package:books_nytimes/MVVM/utils/constants.dart';
import 'package:books_nytimes/MVVM/viewmodels/book_view_model.dart';
import 'package:books_nytimes/MVVM/widgets/circle_image.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  final BookViewModel book;

  BookDetailScreen({@required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller.forward();

    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/gender_neutral_profile_icon.png'),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 150,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Author',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    this.widget.book.author ?? 'Undefined',
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    this.widget.book.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      wordSpacing: 3,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  this.widget.book.publisher,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60 * Constants.heightBlockSize,
                  child: Opacity(
                    opacity: _controller.value,
                    child: CircleImage(
                      imageUrl: this.widget.book.imageUrl,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  this.widget.book.description ?? "No Contents",
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
