import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waffibible/provider/dark_theme_provider.dart';
import 'package:waffibible/provider/database_provider.dart';
import 'package:waffibible/provider/drawer_provider.dart';
import 'package:waffibible/views/books_list.dart';

class MyBottomNav extends StatelessWidget {
  const MyBottomNav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final drawer = Provider.of<DrawerProvider>(context);
    final db = Provider.of<DatabaseProvider>(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: MediaQuery.of(context).size.width * .8,
      height: drawer.drawerStatus ? 0 : 50,
      decoration: BoxDecoration(
        color: themeChange.darkTheme
            ? Color.fromRGBO(50, 50, 50, 1)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Hero(
              tag: 'menu',
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  drawer.drawerStatus = !drawer.drawerStatus;
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: themeChange.darkTheme
                        ? Color.fromRGBO(50, 50, 50, 1)
                        : Theme.of(context).canvasColor,
                    builder: (context) => BooksList(),
                  );
                },
                child: Text(
                  drawer.drawerStatus ? '' : '${db.currentBook}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Tooltip(
              message: 'Notes',
              waitDuration: Duration(milliseconds: 100),
              child: IconButton(
                icon: Icon(Icons.notes),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
