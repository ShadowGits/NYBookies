class BookType {
  String category;

  BookType.createObject({this.category});

  factory BookType.fromJson(Map<String, dynamic> json) {
    return BookType.createObject(category: json['list_name_encoded']);
  }
}
