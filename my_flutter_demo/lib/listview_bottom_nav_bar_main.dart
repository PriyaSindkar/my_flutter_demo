import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(ListViewBottomNavApp());

class ListViewBottomNavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      title: "ListView Types",
      home: */BottomNavigationStatefulWidget();
//    );
  }
}

class BottomNavigationStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavigationState();
  }
}

class BottomNavigationState extends State<BottomNavigationStatefulWidget> {
  int _selectedIndex = 0;
  String _appBarTitle = "ListView Types";

  List<Widget> _listViews = <Widget>[
    InfiniteList(),
    FiniteStaticList(),
    FiniteDynamicList(),
    FiniteDynamicCardItemList()
  ];

  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      title: "ListView Types",
      theme: ThemeData(
          primarySwatch: Colors.purple, accentColor: Colors.lightGreen),
      home: */Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
          elevation: 16,
        ),
        body: Center(
          child: _listViews[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                title: Text(
                  "Infinite ListView",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown),
                ),
                icon: Icon(
                  Icons.list,
                  color: Colors.green,
                  size: 30.0,
                )),
            BottomNavigationBarItem(
                title: Text(
                  "Finite Static ListView",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown),
                ),
                icon: Icon(
                  Icons.view_list,
                  color: Colors.green,
                  size: 30.0,
                )),
            BottomNavigationBarItem(
                title: Text(
                  "Finite Dynamic ListView",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown),
                ),
                icon: Icon(
                  Icons.format_list_numbered,
                  color: Colors.green,
                  size: 30.0,
                )),
            BottomNavigationBarItem(
                title: Text(
                  "With Card Item ListView",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown),
                ),
                icon: Icon(
                  Icons.line_style,
                  color: Colors.green,
                  size: 30.0,
                ))
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.brown,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          backgroundColor: Colors.purple,
        ),
//      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _appBarTitle = "Infinite ListView";
            break;
          }
        case 1:
          {
            _appBarTitle = "Finite Static ListView";
            break;
          }
        case 2:
          {
            _appBarTitle = "Finite Dynamic ListView";
            break;
          }
        case 3:
          {
            _appBarTitle = "With Card Item ListView";
            break;
          }
      }
    });
  }
}

class InfiniteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfiniteListState();
  }
}

class _InfiniteListState extends State<InfiniteList> {
  final List<WordPair> _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          // manually adding divider
          return Divider();
        }
        final int index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class FiniteStaticList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        // remove context if no divider needed
        ListTile(
          title: Text("One"),
        ),
        ListTile(
          title: Text("Two"),
        ),
        ListTile(
          title: Text("Three"),
        ),
      ]).toList(), // remove toList if no divider needed
    );
  }
}

class FiniteDynamicList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FiniteDynamicListState();
  }
}

class _FiniteDynamicListState extends State<FiniteDynamicList> {
  final List<String> _suggestions = <String>[];

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    _suggestions.add("One");
    _suggestions.add("Two");
    _suggestions.add("Three");
    _suggestions.add("Four");

    return ListView.separated /*.builder*/ (
      // remove .separated and add .builder to remove divider line
//      padding: EdgeInsets.all(16),
      itemCount: _suggestions.length,
      itemBuilder: (BuildContext _context, int i) {
        return ListTile(
          leading: Icon(Icons.forward),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            _suggestions[i],
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        );
      },
      separatorBuilder: (context, index) {
        // remove this if no need for separator
        return Divider();
      },
    );
  }
}

class FiniteDynamicCardItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FiniteDynamicCardItemListState();
  }
}

class _FiniteDynamicCardItemListState extends State<FiniteDynamicCardItemList> {
  final List<String> _suggestions = <String>[];

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    _suggestions.add("One");
    _suggestions.add("Two");
    _suggestions.add("Three");
    _suggestions.add("Four");

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (BuildContext _context, int i) {
        return Card(
            margin: EdgeInsets.all(8), elevation: 8, child: _buildCardItem());
      },
    );
  }

  Widget _buildCardItem() {
    return Stack(alignment: AlignmentDirectional.topEnd, children: <Widget>[
      Column(children: <Widget>[
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16),
              child: Image(
                image: AssetImage("assets/images/android.jpg"),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              )),
          Container(
            padding: EdgeInsets.all(16),
//            alignment: Alignment.centerLeft,
            child: Text(
              "Android",
//              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.purple),
            ),
          ),
        ]),
        Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Android is an operating system for mobile phones, tvs, cars",
                style: TextStyle(fontSize: 14, color: Colors.purple),
              ),
            )),
          ],
        )
      ]),
      Padding(padding: EdgeInsets.all(8), child: Icon(Icons.cancel)),
    ]);
  }
}
