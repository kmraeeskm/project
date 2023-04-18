// // compliant by user aadding
// Future<void> adddata() async {
//   try {
//     final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
//     DateTime now = DateTime.now();
//     String formattedDate =
//         "${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}";
//     try {
//       // String postID = const Uuid().v1();
//       // print(postID);

//       Map<String, dynamic> post = {
//         "userid": FirebaseAuth.instance.currentUser!.uid,
//         'time': formattedDate,
//         'text': "there is smell in bathrooooms",
//         'image':
//             "https://firebasestorage.googleapis.com/v0/b/cethostel-f837e.appspot.com/o/Profilepics%2FEnoyUVco5wYye2IfB2zQqKSgf382?alt=media&token=f35f439a-f005-450b-aa8e-bf25fba1727d",
//         'status': "",
//         'rtext': ""
//       };

//       _firebasefirestore
//           .collection('complaints')
//           .doc(formattedDate)
//           .set(post);
//     } catch (error) {
//       print(error);
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }

import 'package:cet_hostel/screens/student_admin/complaints/specific%20_complaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class ComplaintPage extends StatefulWidget {
//   @override
//   _ComplaintPageState createState() => _ComplaintPageState();
// }

// class _ComplaintPageState extends State<ComplaintPage> {
//   List<String> _complaints = [
//     'The wifi in the library is not working',
//     'The cafeteria food is not fresh',
//     'The air conditioning in the classroom is too cold'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     int i = 0;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white, // Set the background color to white
//         bottom: PreferredSize(
//           preferredSize:
//               Size.fromHeight(1.0), // Set the height of the bottom border line
//           child: Container(
//             color: Colors.grey, // Set the color of the bottom border line
//           ),
//         ),
//         title: Container(
//           padding: EdgeInsets.only(left: 130),
//           child: Text(
//             'Complaints',
//             style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Text('Error: ${snapshot.error}');
//           }

//           return ListView(
//             // itemExtent: snapshot.data!.size.toDouble(),
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data() as Map<String, dynamic>;
//               i++;
//               return ListTile(
//                 title: Container(
//                     padding: EdgeInsets.all(2),
//                     margin: EdgeInsets.all(2),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 5.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 0),
//                             child: RichText(
//                               text: TextSpan(
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                 ),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: i.toString() + " : ",
//                                     style: TextStyle(
//                                         color: Color.fromARGB(255, 255, 38, 0)),
//                                   ),
//                                   TextSpan(
//                                     text: data['title'],
//                                     style: TextStyle(
//                                         color: Color.fromARGB(255, 0, 0, 0)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // child: Text(
//                             //   i.toString() + " ${data['title']}",
//                             //   style:
//                             //       TextStyle(fontWeight: FontWeight.bold),
//                             // ),
//                           ),
//                           Container(
//                               margin: EdgeInsets.only(left: 9),
//                               child: Text(
//                                 data['discription'],
//                                 textAlign: TextAlign.left,
//                               )),
//                           Container(
//                             margin: EdgeInsets.only(left: 9),
//                             child: RichText(
//                               text: TextSpan(
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                 ),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: 'status  :  ',
//                                     style: TextStyle(color: Colors.red),
//                                   ),
//                                   TextSpan(
//                                     text: data['status'],
//                                     style: TextStyle(color: Colors.blue),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => specific_complaint(
//                                           title: data['title'],
//                                           description: data['discription'],
//                                           imageUrls: data['image'],
//                                           time: data['time'],
//                                           status: data['status'],
//                                         )));
//                                 // Action to be performed when the button is pressed
//                               },
//                               child: Text('View More'),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 5),
//                             child: Divider(
//                               thickness: 1,
//                               color: Colors.grey,
//                               height: 0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

class ComplaintPage extends StatefulWidget {
  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[400],
          ),
        ),
        title: Center(
          child: Text(
            'Complaints',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => specific_complaint(
                        title: data['title'],
                        description: data['discription'],
                        imageUrls: data['image'],
                        time: data['time'],
                        status: data['status'],
                      ),
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data['title'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: data['status'] == 'Resolved'
                                    ? Colors.green
                                    : Colors.orange,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Text(
                                "status  :  " + data['status'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          data['discription'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
