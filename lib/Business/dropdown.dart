// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:noppon/Business/add_image.dart';
// import 'dart:ui';
// import 'dart:async';
// import 'package:noppon/Business/business_detail.dart';
// import 'package:noppon/Model/place.dart';
// import 'package:noppon/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
// import 'package:noppon/Business/business_edit.dart';

// class Dropdown extends StatelessWidget {
//   var myInitialItem = 'Item 1';
//   List<String> myItems = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//   ];
//   @override
//    Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Dropdowns",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//     );
//   }
// }

// class MultiSelectDialog<V> extends StatefulWidget {
//   MultiSelectDialog({Key key, this.items, this.initialSelectedValues})
//       : super(key: key);

//   final List<MultiSelectDialogItem<V>> items;
//   final Set<V> initialSelectedValues;

//   @override
//   State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
// }

// class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
//   final _selectedValues = Set<V>();

//   void initState() {
//     super.initState();
//     if (widget.initialSelectedValues != null) {
//       _selectedValues.addAll(widget.initialSelectedValues);
//     }
//   }

//   void _onItemCheckedChange(V itemValue, bool checked) {
//     setState(() {
//       if (checked) {
//         _selectedValues.add(itemValue);
//       } else {
//         _selectedValues.remove(itemValue);
//       }
//     });
//   }

//   void _onCancelTap() {
//     Navigator.pop(context);
//   }

//   void _onSubmitTap() {
//     Navigator.pop(context, _selectedValues);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Select Country'),
//       contentPadding: EdgeInsets.only(top: 12.0),
//       content: SingleChildScrollView(
//         child: ListTileTheme(
//           contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
//           child: ListBody(
//             children: widget.items.map(_buildItem).toList(),
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('CANCEL'),
//           onPressed: _onCancelTap,
//         ),
//         FlatButton(
//           child: Text('OK'),
//           onPressed: _onSubmitTap,
//         )
//       ],
//     );
//   }

//   Widget _buildItem(MultiSelectDialogItem<V> item) {
//     final checked = _selectedValues.contains(item.value);
//     return CheckboxListTile(
//       value: checked,
//       title: Text(item.label),
//       controlAffinity: ListTileControlAffinity.leading,
//       onChanged: (checked) => _onItemCheckedChange(item.value, checked),
//     );
//   }
// }

// // ===================

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String value = "";
//   List<DropdownMenuItem<String>> menuitems = List();
//   bool disabledropdown = true;

//   final web = {
//     "1": "PHP",
//     "2": "Python",
//     "3": "Node JSs",
//   };

//   final app = {
//     "1": "Java",
//     "2": "Flutter",
//     "3": "React Native",
//   };

//   final desktop = {
//     "1": "JavaFx",
//     "2": "Tkinter",
//     "3": "Electron",
//   };

//   void populateweb() {
//     for (String key in web.keys) {
//       menuitems.add(DropdownMenuItem<String>(
//         child: Center(
//           child: Text(web[key]),
//         ),
//         value: web[key],
//       ));
//     }
//   }

//   void populateapp() {
//     for (String key in app.keys) {
//       menuitems.add(DropdownMenuItem<String>(
//         child: Center(
//           child: Text(app[key]),
//         ),
//         value: app[key],
//       ));
//     }
//   }

//   void populatedesktop() {
//     for (String key in desktop.keys) {
//       menuitems.add(DropdownMenuItem<String>(
//         child: Center(
//           child: Text(desktop[key]),
//         ),
//         value: desktop[key],
//       ));
//     }
//   }

//   void selected(_value) {
//     if (_value == "Web") {
//       menuitems = [];
//       populateweb();
//     } else if (_value == "App") {
//       menuitems = [];
//       populateapp();
//     } else if (_value == "Desktop") {
//       menuitems = [];
//       populatedesktop();
//     }
//     setState(() {
//       value = _value;
//       disabledropdown = false;
//     });
//   }

//   void secondselected(_value) {
//     setState(() {
//       value = _value;
//     });
//   }

//   List<MultiSelectDialogItem<int>> multiItem = List();

//   final valuestopopulate = {
//     1: "India",
//     2: "Britain",
//     3: "Russia",
//     4: "Canada",
//     5: "Canwefa",
//     6: "Canwefa",
//     7: "Cawwda",
//   };

//   void populateMultiselect() {
//     for (int v in valuestopopulate.keys) {
//       multiItem.add(MultiSelectDialogItem(v, valuestopopulate[v]));
//     }
//   }

//   void _showMultiSelect(BuildContext context) async {
//     multiItem = [];
//     populateMultiselect();
//     final items = multiItem;
//     // final items = <MultiSelectDialogItem<int>>[
//     //   MultiSelectDialogItem(1, 'India'),
//     //   MultiSelectDialogItem(2, 'USA'),
//     //   MultiSelectDialogItem(3, 'Canada'),
//     //   MultiSelectDialogItem(5, 'Canwefa'),
//     // ];

//     final selectedValues = await showDialog<Set<int>>(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelectDialog(
//           items: items,
//           initialSelectedValues: [1, 2].toSet(),
//         );
//       },
//     );

//     print(selectedValues);
//     getvaluefromkey(selectedValues);
//   }

//   void getvaluefromkey(Set selection) {
//     if (selection != null) {
//       for (int x in selection.toList()) {
//         print(valuestopopulate[x]);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Dropdown",
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             DropdownButton<String>(
//               items: [
//                 DropdownMenuItem<String>(
//                   value: "App",
//                   child: Center(
//                     child: Text("App"),
//                   ),
//                 ),
//                 DropdownMenuItem<String>(
//                   value: "Web",
//                   child: Center(
//                     child: Text("Web"),
//                   ),
//                 ),
//                 DropdownMenuItem<String>(
//                   value: "Desktop",
//                   child: Center(
//                     child: Text("Desktop"),
//                   ),
//                 ),
//               ],
//               onChanged: (_value) => selected(_value),
//               hint: Text("Select Your Field"),
//             ),
//             DropdownButton<String>(
//               items: menuitems,
//               onChanged:
//                   disabledropdown ? null : (_value) => secondselected(_value),
//               hint: Text("Select Your Technology"),
//               disabledHint: Text("First Select Your Field"),
//             ),
//             Text(
//               "$value",
//               style: TextStyle(
//                 fontSize: 50.0,
//               ),
//             ),
//             RaisedButton(
//               child: Text("Open Multiselect"),
//               onPressed: () => _showMultiSelect(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
