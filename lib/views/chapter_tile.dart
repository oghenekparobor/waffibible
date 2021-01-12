import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waffibible/models/book.dart';
import 'package:waffibible/provider/database_provider.dart';

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    Key key,
    @required this.chapter,
    @required this.book,
  }) : super(key: key);

  final int chapter;
  final Book book;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DatabaseProvider>(context);
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
        db.readChapter(book, chapter);
        // db.setCurrent(book: book.name, chapter: chapter);
      },
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '$chapter',
        style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 18),
      ),
    );
  }
}
