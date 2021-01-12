import 'package:waffibible/models/chapter.dart';

class Book {
  int id;
  final String name;
  List<Chapter> chapters;

  Book({this.id, this.name, this.chapters});
}
