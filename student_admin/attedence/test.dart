import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class My extends StatefulWidget {
  final String roomid;
  final bool col1;
  final bool col2;
  final bool col3;
  final bool col4;
  const My({
    Key? key,
    required this.roomid,
    required this.col1,
    required this.col2,
    required this.col3,
    required this.col4,
  }) : super(key: key);
  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  late Future<List<String>> _futureDocumentIds;
  List<String> documentIds = [];
  @override
  void initState() {
    super.initState();

    // isValuePresentInArray('w2FhGnHmwwUNMRYaGBpZdSWvscA3');
    print("hi");
    _futureDocumentIds = getDocumentIds(widget.roomid);
    // Future.delayed(Duration(seconds: 1), loadData);
  }

  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  String _username1 = '';
  String _username2 = '';
  String _username3 = '';
  String _username4 = '';
  String _userid1 = '';
  String _userid2 = '';
  String _userid3 = '';
  String _userid4 = '';

  // isValuePresentInArray(String userId) async {
  //   try {
  // DateTime currentDate = DateTime.now();
  // String year = currentDate.year.toString();
  // String month = currentDate.month.toString();
  // String day = currentDate.day.toString();
  //     final CollectionReference usersRef =
  //         FirebaseFirestore.instance.collection('Rooms');
  //     final snapshot = await usersRef
  //         .doc(widget.roomid)
  //         .collection('attendence')
  //         .doc(userId)

  //         .where('precents', arrayContains: year + month + day)
  //         .get();
  //     print(snapshot.docs.isNotEmpty);
  //     print("isprecent");
  //     return snapshot.docs.isNotEmpty;
  //   } catch (e) {
  //     print('Error checking value in array: $e');
  //     return false;
  //   }
  // }
  bool isPresent = false;
  bool isValuePresentInArray(String id) {
    final CollectionReference attendanceRef = FirebaseFirestore.instance
        .collection('Rooms')
        .doc(widget.roomid)
        .collection('attendence');

    List<dynamic>? array = [];

    DateTime currentDate = DateTime.now();
    String year = currentDate.year.toString();
    String month = currentDate.month.toString();
    String day = currentDate.day.toString();
    attendanceRef.doc(id).get().then((doc) {
      if (doc.exists) {
        array = (doc.data() as Map<String, dynamic>)['precents'];
        if (array != null) {
          print(year + month + day);
          isPresent = true;
        }
      }
    });
    print("raees");
    print(isPresent);
    return isPresent;
  }

// Future<void> checkValueInArray(String userId, String checkValue) async {
//   try {
//     final CollectionReference usersRef = FirebaseFirestore.instance.collection('Rooms');
//     final DocumentSnapshot document = await usersRef.doc(widget.roomid).get();
//     final List<dynamic> arrayField = document.data()?['precents'] ?? [];

//     if (arrayField.contains(checkValue)) {
//       setState(() {
//         _isChecked = true;
//       });
//       print('Value is present in array');
//     } else {
//       setState(() {
//         _isChecked = false;
//       });
//       print('Value is not present in array');
//     }
//   } catch (e) {
//     print('Error checking value in array: $e');
//   }
// }
  Future<void> deleteValueFromExistingArray(
      String userId, String valueToDelete) async {
    try {
      final CollectionReference userdd = FirebaseFirestore.instance
          .collection('Rooms')
          .doc(widget.roomid)
          .collection("attendence");
      await userdd.doc(userId).update({
        'precents': FieldValue.arrayRemove([valueToDelete]),
      });
      print('Value deleted from existing array successfully');
    } catch (e) {
      print('Error deleting value from existing array: $e');
    }
  }

  Future<void> addValueToExistingArray(String userId, String newValue) async {
    try {
      final CollectionReference userdd = FirebaseFirestore.instance
          .collection('Rooms')
          .doc(widget.roomid)
          .collection("attendence");
      await userdd.doc(userId).update({
        'precents': FieldValue.arrayUnion([newValue]),
      });
      print('Value added to existing array successfully');
    } catch (e) {
      print('Error adding value to existing array: $e');
    }
  }

  Future<String> getUsernameFromId(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      String username = snapshot.get('username');
      return username;
    } else {
      return 'User not found';
    }
  }

  Future<void> _getUserInfo1(String userId) async {
    _userid1 = userId;
    String username1 = await getUsernameFromId(userId);
    setState(() {
      _username1 = username1;
    });
  }

  Future<void> _getUserInfo2(String userId) async {
    _userid2 = userId;
    String username2 = await getUsernameFromId(userId);
    setState(() {
      _username2 = username2;
    });
  }

  Future<void> _getUserInfo3(String userId) async {
    _userid3 = userId;
    String username3 = await getUsernameFromId(userId);
    setState(() {
      _username3 = username3;
    });
  }

  Future<void> _getUserInfo4(String userId) async {
    _userid4 = userId;
    String username4 = await getUsernameFromId(userId);
    setState(() {
      _username4 = username4;
    });
  }

  // void loadData() {
  //   // load data from an API or database
  //   // set _isLoading to false when the data is loaded
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // Future<String> getUsernameFromId(String userId) async {
  //   DocumentSnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(userId).get();
  //   if (snapshot.exists) {
  //     String username = snapshot.get('username');
  //     return username;
  //   } else {
  //     return 'User not found';
  //   }
  // }

  Future<List<String>> getDocumentIds(String roomId) async {
    List<String> documentIds = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .collection("attendence")
        .get();
    snapshot.docs.forEach((doc) {
      documentIds.add(doc.id);
    });
    return documentIds;
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container Generator'),
        ),
        body: Column(
          children: [
            widget.col1
                ? FutureBuilder<List<String>>(
                    future: _futureDocumentIds,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        _getUserInfo1(snapshot.data![0]);
                        print(documentIds.length);

                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _username1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Checkbox(
                                      value: isValuePresentInArray(
                                          snapshot.data![0]),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked1 = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                : Container(),
            // widget.col2
            //     ? FutureBuilder<List<String>>(
            //         future: _futureDocumentIds,
            //         builder: (BuildContext context,
            //             AsyncSnapshot<List<String>> snapshot) {
            //           if (snapshot.hasData) {
            //             _getUserInfo2(snapshot.data![1]);
            //             print(documentIds.length);

            //             return Column(
            //               children: [
            //                 Card(
            //                   margin: EdgeInsets.symmetric(
            //                       vertical: 8.0, horizontal: 16.0),
            //                   child: InkWell(
            //                     child: Column(
            //                       crossAxisAlignment:
            //                           CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           padding: EdgeInsets.all(16.0),
            //                           decoration: BoxDecoration(
            //                             color: Color.fromARGB(
            //                                 255, 255, 255, 255),
            //                             borderRadius: BorderRadius.only(
            //                               topLeft: Radius.circular(4.0),
            //                               topRight: Radius.circular(4.0),
            //                             ),
            //                           ),
            //                           child: Row(
            //                             children: [
            //                               Expanded(
            //                                 child: Text(
            //                                   _username2,
            //                                   style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontWeight: FontWeight.bold,
            //                                   ),
            //                                   overflow: TextOverflow.ellipsis,
            //                                 ),
            //                               ),
            //                               Checkbox(
            //                                 value: isValuePresentInArray(
            //                                     snapshot.data![1]),
            //                                 onChanged: (bool? value) {
            //                                   setState(() {
            //                                     _isChecked2 = value!;
            //                                   });
            //                                 },
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           } else if (snapshot.hasError) {
            //             return Text('Error: ${snapshot.error}');
            //           } else {
            //             return CircularProgressIndicator();
            //           }
            //         },
            //       )
            //     : Container(),
            // widget.col3
            //     ? FutureBuilder<List<String>>(
            //         future: _futureDocumentIds,
            //         builder: (BuildContext context,
            //             AsyncSnapshot<List<String>> snapshot) {
            //           if (snapshot.hasData) {
            //             _getUserInfo3(snapshot.data![2]);
            //             print(documentIds.length);

            //             return Column(
            //               children: [
            //                 Card(
            //                   margin: EdgeInsets.symmetric(
            //                       vertical: 8.0, horizontal: 16.0),
            //                   child: InkWell(
            //                     child: Column(
            //                       crossAxisAlignment:
            //                           CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           padding: EdgeInsets.all(16.0),
            //                           decoration: BoxDecoration(
            //                             color: Color.fromARGB(
            //                                 255, 255, 255, 255),
            //                             borderRadius: BorderRadius.only(
            //                               topLeft: Radius.circular(4.0),
            //                               topRight: Radius.circular(4.0),
            //                             ),
            //                           ),
            //                           child: Row(
            //                             children: [
            //                               Expanded(
            //                                 child: Text(
            //                                   _username3,
            //                                   style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontWeight: FontWeight.bold,
            //                                   ),
            //                                   overflow: TextOverflow.ellipsis,
            //                                 ),
            //                               ),
            //                               Checkbox(
            //                                 value: isValuePresentInArray(
            //                                     snapshot.data![2]),
            //                                 onChanged: (bool? value) {
            //                                   setState(() {
            //                                     _isChecked3 = value!;
            //                                   });
            //                                 },
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           } else if (snapshot.hasError) {
            //             return Text('Error: ${snapshot.error}');
            //           } else {
            //             return CircularProgressIndicator();
            //           }
            //         },
            //       )
            //     : Container(),
            // widget.col4
            //     ? FutureBuilder<List<String>>(
            //         future: _futureDocumentIds,
            //         builder: (BuildContext context,
            //             AsyncSnapshot<List<String>> snapshot) {
            //           if (snapshot.hasData) {
            //             _getUserInfo4(snapshot.data![3]);
            //             print(documentIds.length);

            //             return Column(
            //               children: [
            //                 Card(
            //                   margin: EdgeInsets.symmetric(
            //                       vertical: 8.0, horizontal: 16.0),
            //                   child: InkWell(
            //                     child: Column(
            //                       crossAxisAlignment:
            //                           CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           padding: EdgeInsets.all(16.0),
            //                           decoration: BoxDecoration(
            //                             color: Color.fromARGB(
            //                                 255, 255, 255, 255),
            //                             borderRadius: BorderRadius.only(
            //                               topLeft: Radius.circular(4.0),
            //                               topRight: Radius.circular(4.0),
            //                             ),
            //                           ),
            //                           child: Row(
            //                             children: [
            //                               Expanded(
            //                                 child: Text(
            //                                   _username4,
            //                                   style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontWeight: FontWeight.bold,
            //                                   ),
            //                                   overflow: TextOverflow.ellipsis,
            //                                 ),
            //                               ),
            //                               Checkbox(
            //                                 value: isValuePresentInArray(
            //                                     snapshot.data![3]),
            //                                 onChanged: (bool? value) {
            //                                   setState(() {
            //                                     _isChecked4 = value!;
            //                                   });
            //                                 },
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           } else if (snapshot.hasError) {
            //             return Text('Error: ${snapshot.error}');
            //           } else {
            //             return CircularProgressIndicator();
            //           }
            //         },
            //       )
            //     : Container(),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        String year = currentDate.year.toString();
                        String month = currentDate.month.toString();
                        String day = currentDate.day.toString();

                        if (_isChecked1) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid1, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid1, year + month + day);
                        }
                        if (_isChecked2) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid2, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid2, year + month + day);
                        }
                        if (_isChecked3) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid3, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid3, year + month + day);
                        }
                        if (_isChecked4) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid4, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid4, year + month + day);
                        }
                      },
                      child: Container(
                          width: 300,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
