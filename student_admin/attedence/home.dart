// import 'package:cet_hostel/screens/student_admin/attedence/attendence_for_room.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class attendence extends StatefulWidget {
//   const attendence({super.key});

//   @override
//   State<attendence> createState() => _attendenceState();
// }

// class _attendenceState extends State<attendence> {
// // to add data in to dataabse
//   Future<void> adddata() async {
//     try {
//       final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;

//       try {
//         // String postID = const Uuid().v1();
//         // print(postID);

//         Map<String, dynamic> post = {
//           "roomid": "LH 04",
//           'm1': "postID",
//           'm2': "profileimage",
//           'm3': "postID",
//           'm4': "profileimage",
//         };

//         _firebasefirestore.collection('rooms').doc('LH 04').set(post);
//       } catch (error) {
//         print(error);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     // adddata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Names List',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('List of Rooms'),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('Rooms').snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Text('Error: ${snapshot.error}');
//             }

//             // if (snapshot.connectionState == ConnectionState.waiting) {
//             //   return Text('Loading...');
//             // }
//             //
//             //   if (snapshot.hasData) {
//             //     QuerySnapshot<Object?>? querySnapshot = snapshot.data;
//             //     print('Documents:');
//             //     for (QueryDocumentSnapshot documentSnapshot
//             //         in querySnapshot!.docs) {
//             //       print(documentSnapshot.data());
//             //     }
//             //   } else {
//             //     print('Snapshot does not have data');
//             //   }
//             //   if (snapshot.hasData) {
//             //     print(snapshot);
//             //     print("object");
//             //     return Text('DATA: is heare');
//             //     print(snapshot);
//             //   } else {
//             //     return Text('DATA: is notttttt heare');
//             //   }
//             // } catch (e) {
//             //   print(e);
//             // }

//             return ListView(
//               // itemExtent: snapshot.data!.size.toDouble(),
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data() as Map<String, dynamic>;
//                 return ListTile(
//                   title: Container(
//                       padding: EdgeInsets.all(10),
//                       margin: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                           width: 0.5,
//                         ),
//                         borderRadius: BorderRadius.circular(6),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                         color: Colors.white,
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => forroom(
//                                     txt: data['roomid'],
//                                     m1: data['m1'],
//                                     m2: data['m2'],
//                                     m3: data['m3'],
//                                     m4: data['m4'],
//                                   )));
//                         },
//                         child: Row(
//                           children: [Text(data['roomid'])],
//                         ),
//                       )),
//                 );
//                 // return ListTile(
//                 //   title: Text(data['phone']),
//                 //   subtitle: Text(data['uid']),
//                 //   // leading: Text(data['profileimage']),
//                 // );
//               }).toList(),
//             );
//           },

//           // body: ListView.builder(
//           //   itemCount: 1,
//           //   itemBuilder: (BuildContext context, int index) {
//           //     return ListTile(
//           //       title: Container(
//           //           padding: EdgeInsets.all(10),
//           //           margin: EdgeInsets.all(10),
//           //           decoration: BoxDecoration(
//           //             border: Border.all(
//           //               color: Colors.black,
//           //               width: 0.5,
//           //             ),
//           //             borderRadius: BorderRadius.circular(6),
//           //             boxShadow: [
//           //               BoxShadow(
//           //                 color: Colors.black.withOpacity(0.2),
//           //                 spreadRadius: 2,
//           //                 blurRadius: 5,
//           //                 offset: Offset(0, 3),
//           //               ),
//           //             ],
//           //             color: Colors.white,
//           //           ),
//           //           child: Row(
//           //             children: [
//           //               ElevatedButton(
//           //                   onPressed: () {
//           //                     final db = FirebaseFirestore.instance;

//           //                     db.collection("attendence").get().then(
//           //                       (querySnapshot) {
//           //                         print("Successfully completed");
//           //                         for (var docSnapshot in querySnapshot.docs) {
//           //                           print(
//           //                               '${docSnapshot.id} => ${docSnapshot.data()}');
//           //                         }
//           //                       },
//           //                       onError: (e) => print("Error completing: $e"),
//           //                     );
//           //                   },
//           //                   child: Text("data"))
//           //             ],
//           //           )),
//           //     );
//           //   },
//           // ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cet_hostel/screens/student_admin/attedence/attendence_for_room.dart';
import 'package:cet_hostel/screens/student_admin/attedence/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewAllRooms extends StatefulWidget {
  const ViewAllRooms({super.key});

  @override
  State<ViewAllRooms> createState() => _ViewAllRoomsState();
}

class _ViewAllRoomsState extends State<ViewAllRooms> {
  late bool col1;
  late bool col2;
  late bool col3;
  late bool col4;
// Add data to Firestore
  Future<int> getCollectionSize() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Rooms')
        .doc('02')
        .collection("attendence")
        .get();
    print("raees");
    print(snapshot.size);
    if (snapshot.size == 4) {
      col4 = true;
      col3 = true;
      col2 = true;
      col1 = true;
    } else if (snapshot.size == 3) {
      col4 = false;
      col3 = true;
      col2 = true;
      col1 = true;
    } else if (snapshot.size == 2) {
      col4 = false;
      col3 = false;
      col2 = true;
      col1 = true;
    } else if (snapshot.size == 1) {
      col4 = false;
      col3 = false;
      col2 = false;
      col1 = true;
    } else {
      col4 = false;
      col3 = false;
      col2 = false;
      col1 = false;
    }
    return snapshot.size;
  }

  @override
  void initState() {
    super.initState();
    getCollectionSize();
  }

  void addData() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Names List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of Rooms'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Rooms').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      // FirebaseFirestore.instance
                      //     .collection('users')
                      //     .doc(data['roomid'])
                      //     .collection("attendence")
                      //     .add({
                      //       'name': 'John Doe',
                      //       'age': 30,
                      //       'email': 'johndoe@example.com'
                      //     })
                      //     .then((value) => print('Data added'))
                      //     .catchError(
                      //         (error) => print('Failed to add data: $error'));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => My(
                                roomid: data['roomid'],
                                col1: col1,
                                col2: col2,
                                col3: col3,
                                col4: col4,
                              )));
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
                                  "Room ID : " + data['roomid'],
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
                                  color: data['vaccency'] != '0'
                                      ? Colors.green
                                      : Colors.orange,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: data['vaccency'] == '0'
                                    ? Text(
                                        "No vaccency",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        "No of vaccency  :  " +
                                            data['vaccency'],
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
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Text(
                            "Corry ID : " + data['corry'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Text(
                            "Floor ID : " + data['floor'],
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
      ),
    );
  }
}
