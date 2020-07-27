import 'package:books_nytimes/MVVM/viewmodels/book_type_view_model.dart';
import "package:flutter/material.dart";

List<DropdownMenuItem> bookTypesToMenuItems(List<BookTypeViewModel> types) {
  List<DropdownMenuItem> items = List<DropdownMenuItem>();
  for (BookTypeViewModel b in types) {
    items.add(new DropdownMenuItem(
      child: Text(b.category),
      value: b.category,
    ));
  }
  return items;
}
