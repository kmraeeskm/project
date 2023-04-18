import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class aloottedrooms extends StatefulWidget {
  const aloottedrooms({super.key});

  @override
  State<aloottedrooms> createState() => _aloottedroomsState();
}

class _aloottedroomsState extends State<aloottedrooms> {
  String? dr;

  Future<String> getUsernameFromUid(String uid) async {
    String username = "";

    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        username = userDoc.get('username');
      } else {
        print('User document not found!');
      }
    } catch (e) {
      print('Error retrieving user document: $e');
    }

    return username;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentById(
      String collectionName, String documentId) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    final documentSnapshot = await collectionRef.doc(documentId).get();
    return documentSnapshot;
  }

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
            stream: FirebaseFirestore.instance
                .collection('roomRequests')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot room = snapshot.data!.docs[index];
                  String roomId = room.id;

                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Card(
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Room ID : " + room['roomid'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('roomRequests')
                                    .doc(roomId)
                                    .collection('requestes')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("Loading...");
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DocumentSnapshot message =
                                          snapshot.data!.docs[index];

                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        margin: EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FutureBuilder<String>(
                                              future: getUsernameFromUid(
                                                  message['requests']),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  // dr = snapshot.data;
                                                  return Text(snapshot.data ??
                                                      "Unknown user");
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                DocumentReference dr =
                                                    FirebaseFirestore.instance
                                                        .collection('Rooms')
                                                        .doc(roomId)
                                                        .collection(
                                                            'attendence')
                                                        .doc(message[
                                                            'requests']);
                                                Map<String, dynamic> data = {
                                                  'id': message['requests'],
                                                  'precents': [],
                                                };
                                                dr.set(data,
                                                    SetOptions(merge: true));

                                                final documentSnapshot =
                                                    await getDocumentById(
                                                        'Rooms', roomId);
                                                final userData =
                                                    documentSnapshot.data();
                                                if (userData!['vaccency'] !=
                                                    '0') {
                                                  int vaccency = int.parse(
                                                      userData['vaccency']);
                                                  print("vaccency");
                                                  print(vaccency);
                                                  int currentmember =
                                                      5 - vaccency;
                                                  String current =
                                                      currentmember.toString();

                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(message['requests'])
                                                      .update({
                                                        'roomid': roomId,
                                                      })
                                                      .then((value) => print(
                                                          "member updated successfully"))
                                                      .catchError((error) => print(
                                                          "Failed to update member: $error"));
                                                  FirebaseFirestore.instance
                                                      .collection('Rooms')
                                                      .doc(roomId)
                                                      .update({
                                                        'memeber' + current:
                                                            message['requests'],
                                                      })
                                                      .then((value) => print(
                                                          "member updated successfully"))
                                                      .catchError((error) => print(
                                                          "Failed to update member: $error"));

                                                  FirebaseFirestore.instance
                                                      .collection('Rooms')
                                                      .doc(roomId)
                                                      .update({
                                                        'vaccency':
                                                            (vaccency - 1)
                                                                .toString(),
                                                      })
                                                      .then((value) => print(
                                                          "vaccency updated successfully"))
                                                      .catchError((error) => print(
                                                          "vaccency to update document: $error"));

                                                  // Create a reference to the document you want to delete
                                                  DocumentReference
                                                      documentReference =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'roomRequests')
                                                          .doc()
                                                          .collection(
                                                              'requestes')
                                                          .doc(message[
                                                              'requests']);

                                                  documentReference
                                                      .delete()
                                                      .then((value) {
                                                    print(
                                                        'Document deleted successfully.');
                                                  }).catchError((error) {
                                                    print(
                                                        'Failed to delete document: $error');
                                                  });

                                                  print(userData['vaccency']);

                                                  final FirebaseFirestore
                                                      _firestore =
                                                      FirebaseFirestore
                                                          .instance;

                                                  String requestId = message[
                                                      'requests']; // The ID of the request you want to delete

// Create a batched write operation
                                                  WriteBatch batch =
                                                      _firestore.batch();

// Query the 'roomRequests' collection for documents that have a 'requestes' subcollection with the specified request ID
                                                  QuerySnapshot
                                                      roomRequestsSnapshot =
                                                      await _firestore
                                                          .collection(
                                                              'roomRequests')
                                                          .where(
                                                              'requestes.$requestId',
                                                              isNotEqualTo:
                                                                  null)
                                                          .get();

// Loop through the documents in the 'roomRequests' collection that have a 'requestes' subcollection with the specified request ID
                                                  roomRequestsSnapshot.docs
                                                      .forEach(
                                                          (roomRequestDoc) {
                                                    // Get a reference to the 'requestes' subcollection of the current document
                                                    CollectionReference
                                                        requestesRef =
                                                        roomRequestDoc.reference
                                                            .collection(
                                                                'requestes');

                                                    // Get a reference to the document in the 'requestes' subcollection with the specified request ID
                                                    DocumentReference
                                                        requestDocRef =
                                                        requestesRef
                                                            .doc(requestId);

                                                    // Add a delete operation for the current document to the batched write operation
                                                    batch.delete(requestDocRef);
                                                  });

// Commit the batched write operation
                                                  batch.commit().then((value) {
                                                    print(
                                                        'Documents deleted successfully.');
                                                  }).catchError((error) {
                                                    print(
                                                        'Failed to delete documents: $error');
                                                  });
                                                } else {
                                                  Widget continueButton =
                                                      TextButton(
                                                    child: Text("Continue"),
                                                    onPressed: () {
                                                      // Do something here
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                }

                                                // print(message['requests']);
                                                // // print(dr);
                                                // print(roomId);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          aloottedrooms()),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.grey[
                                                    700], // Set the background color to a standard gray color
                                                onPrimary: Color.fromARGB(
                                                    255,
                                                    3,
                                                    3,
                                                    3), // Set the text color to white
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                              ),
                                              child: Text('Accept'),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )),
    );
  }
}
