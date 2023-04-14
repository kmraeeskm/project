import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'complintshome.dart';

class specific_complaintforstudentView extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrls;
  final String time;
  final String status;

  specific_complaintforstudentView({
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.time,
    required this.status,
  });

  @override
  State<specific_complaintforstudentView> createState() =>
      _specific_complaintforstudentViewState();
}

class _specific_complaintforstudentViewState
    extends State<specific_complaintforstudentView> {
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
            Container(
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
              child: GestureDetector(
                onTap: () {
                  final docRef = FirebaseFirestore.instance
                      .collection('complaints')
                      .doc(widget.time);

                  // Call the delete() method on the reference
                  docRef
                      .delete()
                      .then((value) => print("Document deleted"))
                      .catchError((error) =>
                          print("Failed to delete document: $error"));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => ComplaintPageView()));
                },
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
