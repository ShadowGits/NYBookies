//import 'package:books_nytimes/MVVM.utils/constants.dart';
//import 'package:books_nytimes/MVVM.viewmodels/book_type_list_view_model.dart';
//import 'package:dropdown_search/dropdown_search.dart';
//import 'package:flutter/material.dart';
//import 'package:loader/loader.dart';
//import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//// TODO: load item list only when there is data in it
//
//class ChooseBookCategory extends StatefulWidget {
//  @override
//  _ChooseBookCategoryState createState() => _ChooseBookCategoryState();
//}
//
//class _ChooseBookCategoryState extends State<ChooseBookCategory>
//    with LoadingMixin<ChooseBookCategory> {
//  String selectedValue;
//  SharedPreferences preferences;
//
//  @override
//  void initState() {
//    super.initState();
//    print("init");
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    var bookTypeListViewModel = Provider.of<BookTypeListViewModel>(context);
//    var itemList = bookTypeListViewModel.types.map((e) => e.category).toList();
//
//    print(itemList);
//    return Container(
//      width: double.infinity,
//      height: 15 * Constants.heightBlockSize,
//      child: DropdownSearch<String>(
//          mode: Mode.DIALOG,
//          showSelectedItem: true,
//          items: itemList,
//          label: "Select a category",
//          hint: "Your book type",
//          popupItemDisabled: (String s) => s.startsWith('I'),
//          onChanged: (value) async {
//            await preferences.setString("bookType", value);
//
//            setState(() {
//              selectedValue = value;
//            });
//          },
//          selectedItem: selectedValue),
//    );
//  }
//
//  @override
//  Future<void> load() async {
//    print("load");
////    preferences = await SharedPreferences.getInstance();
////    selectedValue = preferences.getString("bookType") ?? "HardCover Fiction";
//  }
//}
