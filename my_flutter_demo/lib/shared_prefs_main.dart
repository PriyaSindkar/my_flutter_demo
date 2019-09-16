import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SharedPrefsStatefulWidget(),
    );
  }
}

class SharedPrefsStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SharedPrefsState();
  }
}

class _SharedPrefsState extends State<SharedPrefsStatefulWidget> {
  String _userName = "Guest";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fetchNameFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shared Preferences Demo"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.all(32),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          "Welcome,",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          _userName.toUpperCase(),
                          style: Theme.of(context).textTheme.display1.apply(
                                color: Colors.blue,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Enter your name",
                                    filled: true,
                                    hasFloatingPlaceholder: false,
                                    labelText: "Enter your name",
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      _userName = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please enter your name";
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      RaisedButton(
                                        textColor: Colors.white,
                                        color: Colors.blueGrey,
                                        child: Text("Save Name"),
                                        onPressed: () {
                                          if (_formKey.currentState.validate()) {
                                            _formKey.currentState.save();
                                            _saveNameInPrefs();
                                          }
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                        child: RaisedButton(
                                          textColor: Colors.white,
                                          color: Colors.blueGrey,
                                          child: Text("Clear Details"),
                                          onPressed: () {
                                            _removeNameFromPrefs();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    "Not \'$_userName\'? Enter name above",
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  void _saveNameInPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", _userName);
  }

  void _fetchNameFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString("username") ?? "Guest";
    });
  }

  void _removeNameFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    setState(() {
      _userName = "Guest";
    });
  }
}
