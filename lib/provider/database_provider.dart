import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:waffibible/models/book.dart';

class DatabaseProvider with ChangeNotifier {
  List<Book> _books = [];
  List<String> verse = [];
  String current = '';
  Database db;
  int _chapter = 0;

  int bkid;
  String bname;
  int chap;

  Future<bool> _initialize() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'bible_db.db');
    this.db = await openDatabase(databasePath);
    return true;
  }

  List<dynamic> get values {
    return [bkid, chap, bname];
  }

  int get chapterCount {
    return _chapter;
  }

  List<Book> get allBook {
    return [..._books];
  }

  List<String> get verses {
    return [...verse];
  }

  String get currentBook {
    return current;
  }

  Future<void> getBooks() async {
    _initialize().then((initialized) async {
      if (!initialized) await this._initialize();
      String query = '''SELECT * FROM key_english''';
      var book = await this.db.rawQuery(query);

      book.forEach((element) {
        _books.add(
          Book(name: element['n'], id: element['b']),
        );
      });

      setCurrent(book: book.first['n'], bn: book.first['b']);
      readChapter(Book(id: book.first['b'], name: book.first['n']), 1);
      notifyListeners();
    });
  }

  setCurrent({book, chapter = 1, bn}) async {
    current = '$book $chapter';

    // bkid = bn;
    // chap = chapter;
    // bname = book;
    notifyListeners();
  }

  Future<int> getChapters(Book book) async {
    // int chapter = 0;
    _initialize().then((initialized) async {
      if (!initialized) await this._initialize();
      String query =
          '''SELECT COUNT(*) FROM t_kjv WHERE t_kjv.b = '${book.id}' GROUP BY t_kjv.c''';
      var chap = await this.db.rawQuery(query);
      _chapter = chap.length;
      notifyListeners();
    });
    return _chapter;
  }

  Future<void> gotoNext({bookname, bookid, chapt}) async {}

  Future<void> readChapter(Book book, chapter) async {
    verse.clear();
    _initialize().then((initialized) async {
      if (!initialized) await this._initialize();
      String query =
          '''SELECT * FROM t_kjv WHERE t_kjv.b = '${book.id}' AND t_kjv.c = '$chapter' ''';
      var chap = await this.db.rawQuery(query);
      chap.forEach((element) {
        verse.add(element['t']);
      });
      setCurrent(book: book.name, bn: book.id, chapter: chapter);
      notifyListeners();
    });
  }
}
