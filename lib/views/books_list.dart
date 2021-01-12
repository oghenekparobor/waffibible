import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waffibible/provider/database_provider.dart';
import 'package:waffibible/views/chapter_tile.dart';

// ignore: must_be_immutable
class BooksList extends StatefulWidget {
  BooksList({Key key}) : super(key: key);

  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DatabaseProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListView(
        key: Key('builder ${selected.toString()}'),
        children: db.allBook
            .map((e) => ExpansionTile(
                  key: Key('${e.id}'),
                  title: Text(
                    e.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 20),
                  ),
                  // initiallyExpanded: e.id == selected,
                  maintainState: true,
                  onExpansionChanged: (value) {
                    if (value) db.getChapters(e);
                  },
                  children: [
                    Consumer<DatabaseProvider>(
                      builder: (context, value, child) => Wrap(
                        spacing: -15.0,
                        children: [
                          for (var i = 0; i < value.chapterCount; i++)
                            ChapterTile(chapter: i + 1, book: e)
                        ],
                      ),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
