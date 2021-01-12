import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waffibible/provider/dark_theme_provider.dart';
import 'package:waffibible/provider/drawer_provider.dart';
import 'package:waffibible/views/adjust_font_size.dart';

class MySideDrawer extends StatelessWidget {
  const MySideDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final drawer = Provider.of<DrawerProvider>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: drawer.drawerStatus ? MediaQuery.of(context).size.width * .2 : 0,
      color: themeChange.darkTheme
          ? Color.fromRGBO(50, 50, 50, 1)
          : Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Hero(
          tag: 'menu',
          child: drawer.drawerStatus
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Close drawer',
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          drawer.drawerStatus = !drawer.drawerStatus;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Tooltip(
                      message: 'Bible translation',
                      child: IconButton(
                        icon: Icon(Icons.translate_outlined),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 15),
                    Tooltip(
                      message: 'Search bible',
                      child: IconButton(
                        icon: Icon(Icons.search_outlined),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 15),
                    Tooltip(
                      message: 'Adjust font size',
                      child: IconButton(
                        icon: Icon(Icons.text_fields_outlined),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AdjustFontSize(),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Tooltip(
                      message: 'Switch theme mode',
                      child: IconButton(
                        icon: Icon(
                          themeChange.darkTheme
                              ? Icons.lightbulb
                              : Icons.lightbulb_outline,
                        ),
                        onPressed: () {
                          themeChange.darkTheme = !themeChange.darkTheme;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    IconButton(
                      icon: Icon(Icons.settings_outlined),
                      onPressed: () {},
                    ),
                  ],
                )
              : Column(),
        ),
      ),
    );
  }
}
