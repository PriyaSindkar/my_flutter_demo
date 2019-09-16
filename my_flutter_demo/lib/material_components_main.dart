import 'package:flutter/material.dart';

void main() {
  runApp(TabBarApp());
}

class TabBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      title: "TabBar Demo",
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.black,
      ),
      home:*/ DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("TabBar Demo"),
              elevation: 16,
//              leading: Icon(Icons.keyboard_backspace),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: "Form Fields",
                    icon: Icon(Icons.input),
                  ),
                  Tab(
                    text: "Dialogs",
                    icon: Icon(Icons.crop_square),
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              _InputFormStatefulWidget(),
              Text("This is where different dialogs will be shown")
            ]),
          )/*)*/,
    );
  }
}

class _InputFormStatefulWidget extends StatefulWidget {
  @override
  _InputFormState createState() {
    return _InputFormState();
  }
}

class _InputFormState extends State<_InputFormStatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _userNameFocusNode;
  FocusNode _passwordFocusNode;

  final List<CheckboxData> _checkBoxStates = <CheckboxData>[
    CheckboxData("Selection 1", false),
    CheckboxData("Selection 2", false),
    CheckboxData("Selection 3", false)
  ];
  List<String> _checkBoxSelectionList = <String>[];

  RadioButtonValues _selectedRadioListTileButton = RadioButtonValues.Option1;
  RadioButtonValues _selectedRadioButton = RadioButtonValues.Option1;
  bool _isSwitchOn = false;
  String _switchText = "Status: OFF";
  final List<String> _dropDownMenuItemsList = <String>[
    "Select Item",
    "One",
    "Two",
    "Three",
    "Four"
  ];

  String _selectedDropDownItem = "";

  @override
  void initState() {
    _selectedDropDownItem = _dropDownMenuItemsList.elementAt(0);
    _userNameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // to set the flow of children from left side, default is  center position
                    children: <Widget>[
                      _buildUserNameTextForm(context),
                      _buildPasswordFormField(context),
                      checkBoxSelections(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text("Example of RadioListTile which is always vertical"),
                      ),
                      verticalRadioButtonTiles(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text("Example of Radio which can be made horizontal"),
                      ),
                      horizontalRadioButtons(),
                      switchField(),
                      _buildDropDownFormField(),
                      formButtons(context),
                    ],
                  )),
            )));
  }

  TextFormField _buildUserNameTextForm(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      focusNode: _userNameFocusNode,
      decoration: InputDecoration(
          helperText: "Compulsory Field (helper text)",
          labelText: "Enter Username",
          hasFloatingPlaceholder: true,
          border: OutlineInputBorder()),
      validator: (value) {
        if (value.isEmpty) {
          FocusScope.of(context).requestFocus(_userNameFocusNode);
          return "Required Field";
        }
        return null;
      },
    );
  }

  Padding _buildPasswordFormField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: TextFormField(
        obscureText: true,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
            helperText: "Compulsory Field (helper text)",
            labelText: "Enter Password",
            hasFloatingPlaceholder: true,
            border: UnderlineInputBorder()),
        validator: (value) {
          if (value.isEmpty) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
            return "Required Field";
          }
          return null;
        },
      ),
    );
  }

  FormField<String> checkBoxSelections() {
    return FormField<String>(
        // making checkbox selections as custom form fields in order to validate if any one is selected when submit is clicked
        initialValue: "",
        autovalidate: false,
        validator: (value) {
          if (value.isEmpty) {
            return "Please select any one selections";
          }
        },
        builder: (FormFieldState<String> state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Wrap(
              spacing: 10,
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: _buildCheckboxes(state),
            ),
          );
        });
  }

  List<Widget> _buildCheckboxes(FormFieldState<String> state) {
    List<Widget> _widgets = <Widget>[];

    for (var i = 0; i < _checkBoxStates.length; i++) {
      _widgets.add(Column(children: <Widget>[
        Text(_checkBoxStates.elementAt(i).text),
        Checkbox(
          value: _checkBoxStates.elementAt(i).isChecked,
          onChanged: (bool value) {
            setState(() {
              _checkBoxStates.elementAt(i).isChecked = !_checkBoxStates.elementAt(i).isChecked;
            });
            if (_checkBoxStates.elementAt(i).isChecked) {
              _checkBoxSelectionList.add(_checkBoxStates.elementAt(i).text);
            } else {
              _checkBoxSelectionList.remove(_checkBoxStates.elementAt(i).text);
            }
            state.didChange(_checkBoxSelectionList.join(","));
          },
          tristate: true,
        ),
      ]));
    }
    // add error text state to display error for selection on form validation
    _widgets.add(state.hasError
        ? Text(
            state.errorText,
            style: TextStyle(color: Colors.red),
          )
        : Container());
    return _widgets;
  }

  Padding verticalRadioButtonTiles() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Wrap(
        children: _buildVerticalRadioListTileButtons(),
      ),
    );
  }

  // vertical list of radio buttons
  List<Widget> _buildVerticalRadioListTileButtons() {
    List<Widget> _widgets = <Widget>[];

    for (var i = 0; i < RadioButtonValues.values.length; i++) {
      _widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RadioListTile<RadioButtonValues>(
            activeColor: Colors.red,
            groupValue: _selectedRadioListTileButton,
            value: RadioButtonValues.values.elementAt(i),
            title: Text("Option: " + (i + 1).toString()),
            onChanged: (RadioButtonValues value) {
              setState(() {
                _selectedRadioListTileButton = value;
              });
            },
          ),
        ],
      ));
    }
    return _widgets;
  }

  Padding horizontalRadioButtons() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: _buildHorizontalRadioButtons(),
      ),
    );
  }

  // horizontal list of radio buttons
  List<Widget> _buildHorizontalRadioButtons() {
    List<Widget> _widgets = <Widget>[];

    for (var i = 0; i < RadioButtonValues.values.length; i++) {
      _widgets.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio<RadioButtonValues>(
              value: RadioButtonValues.values.elementAt(i),
              groupValue: _selectedRadioButton,
              onChanged: (RadioButtonValues value) {
                setState(() {
                  _selectedRadioButton = value;
                });
              },
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _selectedRadioButton = RadioButtonValues.values.elementAt(i);
                });
              },
              child: Text("HOption: " + (i + 1).toString()),
            ),
          ],
        ),
      );
    }

    return _widgets;
  }

  Padding switchField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Row(
        children: _buildSwitchField(),
      ),
    );
  }

  List<Widget> _buildSwitchField() {
    return <Widget>[
      Text(_switchText),
      Switch(
        activeColor: Colors.green,
        inactiveThumbColor: Colors.blueAccent,
        inactiveTrackColor: Colors.blueAccent.withAlpha(100),
        value: _isSwitchOn,
        onChanged: (value) {
          setState(() {
            _isSwitchOn = value;
            if (value) {
              _switchText = "Status: ON";
            } else {
              _switchText = "Status: OFF";
            }
          });
        },
      )
    ];
  }

  Padding _buildDropDownFormField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == "Select Item") {
            return "Please select any one item from drop down";
          }
        },
        hint: Text("Select Item"),
        onChanged: (String newValue) {
          setState(() {
            _selectedDropDownItem = newValue;
          });
        },
        value: _selectedDropDownItem,
        items: _buildDropDownMenuItems(),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuItems() {
    List<DropdownMenuItem<String>> _list = <DropdownMenuItem<String>>[];

    for (int i = 0; i < _dropDownMenuItemsList.length; i++) {
      _list.add(DropdownMenuItem(
        value: _dropDownMenuItemsList.elementAt(i),
        child: Text(_dropDownMenuItemsList.elementAt(i)),
      ));
    }
    return _list;
  }

  Padding formButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildFormButtons(context),
      ),
    );
  }

  List<Widget> _buildFormButtons(BuildContext context) {
    return <Widget>[
      RaisedButton(
          color: Colors.red,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          highlightColor: Colors.black,
          padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Text("Submit"),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Saving Data..."),
                duration: Duration(seconds: 5),
              ));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Some missing inputs found..."),
                duration: Duration(seconds: 5),
              ));
            }
          }),
      Padding(
        padding: EdgeInsets.all(16),
        child: OutlineButton(
          child: Text("Reset"),
          onPressed: () {
            _formKey.currentState.reset();
          },
          splashColor: null,
          highlightedBorderColor: Colors.transparent,
          highlightColor: null,
        ),
      ),
    ];
  }
}

class CheckboxData {
  String text;
  bool isChecked;

  CheckboxData(this.text, this.isChecked);
}

enum RadioButtonValues { Option1, Option2, Option3, Option4 }
