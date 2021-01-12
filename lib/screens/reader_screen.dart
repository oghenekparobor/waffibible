import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waffibible/models/book.dart';
import 'package:waffibible/models/chapter.dart';
import 'package:waffibible/provider/database_provider.dart';
import 'package:waffibible/provider/font_size_provider.dart';
import 'package:waffibible/views/my_bottom_nav.dart';
import 'package:waffibible/views/my_side_drawer.dart';

// ignore: must_be_immutable
class ReaderScreen extends StatefulWidget {
  ReaderScreen({this.book, this.chapter, this.chapterText, this.verseNumber});
  final Book book;
  final Chapter chapter;
  TextSpan chapterText;
  // final Function scrollToVerseMethod;
  final int verseNumber;

  @override
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  // ignore: unused_element
  List<InlineSpan> _flattenTextSpans(List<InlineSpan> iterable) {
    return iterable
        // ignore: deprecated_member_use
        .expand((InlineSpan e) => e.children != null && e.children.length > 0
            // ignore: deprecated_member_use
            ? _flattenTextSpans(e.children.whereType<InlineSpan>().toList())
            : [e])
        .toList();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      Provider.of<DatabaseProvider>(context, listen: false).getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Provider.of<FontSizeProvider>(context);
    final db = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: Row(
          children: [
            MySideDrawer(),
            Expanded(
              child: Stack(
                children: [
                  Consumer<DatabaseProvider>(
                    builder: (context, value, child) {
                      return Dismissible(
                        key: Key(value.currentBook),
                        
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            var dd = value.values;
                            db.gotoNext(
                                bookid: dd[0], chapt: dd[1], bookname: dd[2]);
                          } else {
                            //previous
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                '${value.current}',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(height: 10),
                              for (var i = 0; i < value.verses.length; i++)
                                Text(
                                  '${i + 1}. ${value.verses[i]}\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontSize: size.fontSize),
                                ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MyBottomNav(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
