import 'package:cet_hostel/screens/student/specific_complaintforstudentView.dart';
import 'package:cet_hostel/screens/student_admin/complaints/specific%20_complaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addcomplaint.dart';

class ComplaintPageView extends StatefulWidget {
  @override
  _ComplaintPageViewState createState() => _ComplaintPageViewState();
}

class _ComplaintPageViewState extends State<ComplaintPageView> {
  String currentuser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    int i = 0;
    print(currentuser);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white, // Set the background color to white
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                  1.0), // Set the height of the bottom border line
              child: Container(
                color: Colors.grey, // Set the color of the bottom border line
              ),
            ),
            title: Container(
              padding: EdgeInsets.only(left: 130),
              child: Text(
                'Complaints',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('complaints')
                .where('userid', isEqualTo: currentuser)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Error: ${snapshot.error}');
              }

              return ListView(
                // itemExtent: snapshot.data!.size.toDouble(),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  i++;
                  return ListTile(
                    title: Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.all(2),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: i.toString() + " : ",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 38, 0)),
                                      ),
                                      TextSpan(
                                        text: data['title'],
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ],
                                  ),
                                ),
                                // child: Text(
                                //   i.toString() + " ${data['title']}",
                                //   style:
                                //       TextStyle(fontWeight: FontWeight.bold),
                                // ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 9),
                                  child: Text(
                                    data['discription'],
                                    textAlign: TextAlign.left,
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: 9),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'status  :  ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: data['status'],
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                specific_complaintforstudentView(
                                                  title: data['title'],
                                                  description:
                                                      data['discription'],
                                                  imageUrls: data['image'],
                                                  time: data['time'],
                                                  status: data['status'],
                                                )));
                                    // Action to be performed when the button is pressed
                                  },
                                  child: Text('View More'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                }).toList(),
              );
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (builder) => complintr()));
              print("hi");
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
