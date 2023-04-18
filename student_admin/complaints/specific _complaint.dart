import 'package:cet_hostel/screens/student_admin/mainhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class specific_complaint extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrls;
  final String time;
  final String status;

  specific_complaint(
      {required this.title,
      required this.description,
      required this.imageUrls,
      required this.status,
      required this.time});

  @override
  State<specific_complaint> createState() => _specific_complaintState();
}

class _specific_complaintState extends State<specific_complaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        // Add other AppBar properties here
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(widget.description, style: TextStyle(fontSize: 25)),
            ),
            Center(
                child: Image.network(widget.imageUrls,
                    height: 400, fit: BoxFit.contain)),
            Container(
              padding: EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'status : ',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      text: widget.status,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final docRef = FirebaseFirestore.instance
                    .collection('complaints')
                    .doc(widget.time);
                // Update the document
                try {
                  await docRef.update({
                    'status': 'submit to warden',
                  });
                } catch (e) {
                  print(e);
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage(bar: 2)));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 5, 20, 235),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.grey,
                ),
                child: Center(
                    child: Text(
                  "submit to warden",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final docRef = FirebaseFirestore.instance
                    .collection('complaints')
                    .doc(widget.time);
                // Update the document
                try {
                  await docRef.update({
                    'status': 'Action on process',
                  });
                } catch (e) {
                  print(e);
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage(bar: 2)));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 5, 20, 235),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.grey,
                ),
                child: Center(
                    child: Text(
                  "Action on process",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final docRef = FirebaseFirestore.instance
                    .collection('complaints')
                    .doc(widget.time);
                // Update the document
                try {
                  await docRef.update({
                    'status': 'Delete complaint',
                  });
                } catch (e) {
                  print(e);
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage(bar: 2)));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 4, 45, 178),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.grey,
                ),
                child: Center(
                    child: Text(
                  "Delete complaint",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
