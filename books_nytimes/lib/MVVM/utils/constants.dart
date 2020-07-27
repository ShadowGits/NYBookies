import 'package:flutter/material.dart';

enum CategoryLoadingStatus { completed, loading, empty }

class Constants {
  static String getImageURL(String id) {
    const String IMAGE_URL_HEADER = "https://s1.nyt.com/du/books/images/";
    return IMAGE_URL_HEADER + "$id.jpg";
  }

  static const MY_API_KEY_NY_TIMES = "PKM5yWQ5XyWsPPeBCX4R09DGh1q5MCQZ";

  static const GET_BOOK_TYPE_LISTS_URL =
      "https://api.nytimes.com/svc/books/v3/lists/names";

  static const END_PART_OF_URL = ".json?api-key=";

  static const GET_BOOK_NAMES_CURRENT_OF_TYPE_URL =
      "https://api.nytimes.com/svc/books/v3/lists/";

  static double heightBlockSize;
  static double widthBlockSize;
  static const Radius borderRadiusNameCard = Radius.circular(30);

// ignore: non_constant_identifier_names

}
