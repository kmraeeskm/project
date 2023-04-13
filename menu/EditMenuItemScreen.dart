import 'package:cet_hostel/screens/student_admin/menu/nonvegmenu.dart';
import 'package:cet_hostel/screens/student_admin/menu/vegmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditMenuItemScreen extends StatefulWidget {
  final String time;
  final String day;
  final String type;

  EditMenuItemScreen({
    required this.time,
    required this.day,
    required this.type,
  });

  @override
  _EditMenuItemScreenState createState() => _EditMenuItemScreenState();
}

class _EditMenuItemScreenState extends State<EditMenuItemScreen> {
  TextEditingController _day = TextEditingController();
  TextEditingController _time = TextEditingController();
  TextEditingController _items = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('menu')
        .doc(widget.type)
        .collection(widget.type)
        .doc(widget.day)
        .get();
    final data = documentSnapshot.data();
    final fieldValue = data![widget.time];
    if (fieldValue is String) {
      _items.text = fieldValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    _day.text = widget.day;
    _time.text = widget.time;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 11, 11, 11), // Change the color here
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            // Add your navigation logic here
          },
        ), // Set the background color to white
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(1.0), // Set the height of the bottom border line
          child: Container(
            color: Colors.grey, // Set the color of the bottom border line
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            'Edit Menu Items',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name of the day:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _day,
                decoration: InputDecoration(
                  // hintText: 'Enter menu item name',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Time of the day:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _time,
                decoration: InputDecoration(
                  // hintText: 'Enter menu item name',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Menu Item Description:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _items,
                decoration: InputDecoration(
                  // hintText: 'Enter menu item description',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final docRef = FirebaseFirestore.instance
                      .collection('menu')
                      .doc(widget.type)
                      .collection(widget.type)
                      .doc(widget.day);
                  // Update the document
                  try {
                    await docRef.update({
                      widget.time: _items.text,
                    });
                  } catch (e) {
                    print(e);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => widget.type == "veg"
                              ? vegmenu()
                              : nonvegmenu())).then((result) {
                    // Handle the result returned from PageB
                  });
                },
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
