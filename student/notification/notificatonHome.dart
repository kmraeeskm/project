import 'package:cet_hostel/screens/student/specific_complaintforstudentView.dart';
import 'package:cet_hostel/screens/student_admin/notification/addNotification.dart';
import 'package:cet_hostel/screens/student_admin/mainhome.dart';
import 'package:cet_hostel/screens/student_admin/complaints/specific%20_complaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class notificationHomeforstudents extends StatefulWidget {
  @override
  _notificationHomeforstudentsState createState() =>
      _notificationHomeforstudentsState();
}

class _notificationHomeforstudentsState
    extends State<notificationHomeforstudents> {
  String currentuser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    // String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

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
              padding: EdgeInsets.only(left: 110),
              child: Text(
                'Notifications',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notification')
                .where('duedate', isGreaterThanOrEqualTo: formattedDate)
                .orderBy('duedate', descending: false)
                .orderBy('time', descending: true)
                // .orderBy('duedate', descending: true)
                // .where('duetime', isGreaterThan: currentTime)
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
                  print(data['duedate']);
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: data['text'],
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.notifications,
                                        color: data['selectedtype'] == 'Normal'
                                            ? Color.fromARGB(255, 14, 233, 7)
                                            : Color.fromARGB(255, 243, 33, 33),
                                      ),
                                      // child: ElevatedButton(
                                      //   onPressed: () {},
                                      //   child: Text(
                                      //     data['selectedtype'],
                                      //     style: TextStyle(
                                      //         color: Color.fromARGB(
                                      //             255, 255, 255, 255)),
                                      //   ),
                                      //   style: ElevatedButton.styleFrom(
                                      //     backgroundColor:
                                      //         data['selectedtype'] == 'Normal'
                                      //             ? Color.fromARGB(
                                      //                 255, 14, 233, 7)
                                      //             : Color.fromARGB(
                                      //                 255, 243, 33, 33),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                child: Divider(
                                  thickness: 1,
                                  color: data['selectedtype'] == 'Normal'
                                      ? Color.fromARGB(255, 14, 233, 7)
                                      : Color.fromARGB(255, 243, 33, 33),
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
      ],
    );
  }
}
