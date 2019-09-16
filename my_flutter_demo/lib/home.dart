import 'package:flutter/material.dart';
import 'package:my_flutter_demo/dbexample.dart';
import 'package:my_flutter_demo/listview_bottom_nav_bar_main.dart';
import 'package:my_flutter_demo/main.dart';
import 'package:my_flutter_demo/material_components_main.dart';
import 'package:my_flutter_demo/shared_prefs_main.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey, accentColor: Colors.black),
      home: HomeApp(),
    ));

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green, accentColor: Colors.black),
      home:*/
        Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MaterialButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              elevation: 4,
              shape: BeveledRectangleBorder(side: BorderSide(style: BorderStyle.none),borderRadius: BorderRadius.circular(16)),
              child: Text("My First Flutter App"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')));
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Text("ListView Examples"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ListViewBottomNavApp()));
              },
            ),
            OutlineButton(
              color: Colors.transparent,
              shape: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blueGrey, width: 0.5, style: BorderStyle.solid),),
              child: Text("TabBar with form fields"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarApp()));
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
              child: Text("Shared Preferences Examples"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SharedPrefsApp()));
              },
            ),RaisedButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
              child: Text("Local Database Example"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DatabaseExampleApp()));
              },
            ),
          ],
        ),
      ),
      /*),*/
    );
  }
}
