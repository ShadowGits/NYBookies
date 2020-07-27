class Book {
  int rank;
  String primaryISBN;
  String publisher;
  String title;
  String description;
  String author;
  String imageUrl;

  @override
  String toString() {
    return 'Book{rank: $rank, primaryISBN: $primaryISBN, publisher: $publisher, title: $title, description: $description, author: $author, imageUrl: $imageUrl}';
  }

  Book.createBook(
      {this.rank,
      this.primaryISBN,
      this.publisher,
      this.title,
      this.description,
      this.author,
      this.imageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book.createBook(
      rank: json['rank'],
      primaryISBN: json['primary_isbn13'],
      publisher: json['publisher'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      imageUrl: json['book_image'],
    );
  }
}
