import 'package:waffibible/models/book.dart';

class Chapter {
  int id;
  Book book;
  int number;

  Chapter({this.number, this.book});

  @override
  String toString() {
    return "${book.name} $number";
  }

  @override
  int get hashCode {
    return ("${book.name} + $number").hashCode;
  }

  operator ==(Object other) => hashCode == other.hashCode;
}
