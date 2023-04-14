import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String _selectedItem = "";
  List<String> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    _getDropdownItems();
  }

  Future<void> _getDropdownItems() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('roooms')
        .where('vaccency', isNotEqualTo: '0')
        .get();
    final List<String> items =
        snapshot.docs.map((doc) => doc.data()['roomid'] as String).toList();
    setState(() {
      _dropdownItems = items;
      _selectedItem = _dropdownItems[0]; // set initial value
    });
  }

  List<String> _items = [];
  Future<void> _saveItemsToFirestore() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('roomRequests')
        .doc(_selectedItem)
        .get();
    if (!docSnapshot.exists) {
      print("exist");
      await FirebaseFirestore.instance
          .collection('roomRequests')
          .doc(_selectedItem)
          .set({
        // 'requests': [],
        'roomid': _selectedItem,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await FirebaseFirestore.instance
          .collection('roomRequests')
          .doc(_selectedItem)
          .collection('requestes')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          // DateTime.now().millisecondsSinceEpoch.toString()
          .set({
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'requests': [],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dropdownString = _dropdownItems.join(', ');
    return Material(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select an item',
                border: OutlineInputBorder(),
              ),
              value: _selectedItem,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value!;
                  print(_selectedItem);
                });
              },
              items: _dropdownItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Dropdown items: $dropdownString'),
            ElevatedButton(
                onPressed: () async {
                  _saveItemsToFirestore();
                  _items.add(_selectedItem);
                  // await FirebaseFirestore.instance
                  //     .collection('roomRequests')
                  //     .doc(_selectedItem)
                  //     .set({
                  //   'roomid': _selectedItem,
                  //   'requests`':

                  // });
                  // Scaffold.of(context).showSnackBar(
                  //   SnackBar(content: Text('Data saved')),
                  // );

                  // FirebaseFirestore.instance
                  //     .collection('roomRequests')
                  //     .doc(_selectedItem)
                  //     .collection('requestes')
                  //     .doc(
                  //       FieldValue.serverTimestamp() as String?,
                  //     )
                  //     .update({
                  //   'requests': FieldValue.arrayUnion(
                  //       [FirebaseAuth.instance.currentUser!.uid])
                  // });
                },
                child: Text(_selectedItem))
          ],
        ),
      ),
    );
  }
}
