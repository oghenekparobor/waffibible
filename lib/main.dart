import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:waffibible/helper/dark_theme_style.dart';
import 'package:waffibible/provider/dark_theme_provider.dart';
import 'package:waffibible/provider/database_provider.dart';
import 'package:waffibible/provider/drawer_provider.dart';
import 'package:waffibible/provider/font_size_provider.dart';
import 'package:waffibible/screens/reader_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  FontSizeProvider fontSizeProvider = new FontSizeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    copyDatabase();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

// add a loading screen that say organizing database
  Future<void> copyDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "bible_db.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(
        join('assets', 'database/bible-sqlite.db'),
      );
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await new File(path).writeAsBytes(bytes);
      print('copied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeChangeProvider),
        ChangeNotifierProvider.value(value: DrawerProvider()),
        ChangeNotifierProvider.value(value: FontSizeProvider()),
        ChangeNotifierProvider.value(value: DatabaseProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext ctx, value, child) => MaterialApp(
          title: 'Waffi Bible',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeChangeProvider.darkTheme, ctx),
          home: FutureBuilder(
            future: copyDatabase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(child: CircularProgressIndicator()),
                        Text(
                          'Please wait!',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return ReaderScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
