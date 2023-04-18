import 'package:cet_hostel/screens/student_admin/attedence/attendence_for_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class forroom extends StatefulWidget {
  const forroom({
    Key? key,
    required this.roomid,
  }) : super(key: key);
  // Step 2 <-- SEE HERE
  final String roomid;

  @override
  State<forroom> createState() => _forroomState();
}

class _forroomState extends State<forroom> {
  @override
  void initState() {
    super.initState();
    getDocumentIds(widget.roomid);
  }

  Future<List<String>> getDocumentIds(String roomId) async {
    List<String> documentIds = [];

    await FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .collection("attendence")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        documentIds.add(doc.id);
      });
    });

    return documentIds;
  }

  bool selectedm1 = false;
  bool selectedm2 = false;
  bool selectedm4 = false;
  bool selectedm3 = false;
  bool v = false;
  bool isChecked = false;
  bool _toggleColor(int index) {
    if (index == 0) {
      selectedm1 = !selectedm1;
      return selectedm1;
    } else if (index == 1) {
      selectedm2 = !selectedm2;
      return selectedm2;
    } else if (index == 2) {
      selectedm3 = !selectedm3;
      return selectedm3;
    } else {
      selectedm4 = !selectedm4;
      return selectedm4;
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

  int countDocuments(QuerySnapshot<Object?>? snapshot) {
    print("inside cound");
    print(snapshot?.size);
    return snapshot?.size ?? 0;
  }

  late int count;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Names List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of students'),
        ),
        body: Stack(children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Rooms')
                .doc(widget.roomid)
                .collection("attendence")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                // final count = countDocuments(snapshot.data);
                // print(count);
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                count = countDocuments(snapshot.data);
                //   return Text('Number of documents: $count');
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => forroom(
                        //           roomid: data['roomid'],
                        //         )));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              // print("pressed");
                              // print(index);
                              // print(v);
                              setState(() {
                                v = _toggleColor(index);
                                print(count);
                              });

                              // print(v);
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: index == 1
                                    ? Colors.red
                                    : Color.fromARGB(255, 238, 234, 234),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FutureBuilder(
                                      future: getUsernameFromId(data['id']),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData) {
                                          return Text('${snapshot.data}');
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked = newValue!;
                                      });
                                    },
                                  ),
                                ],
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
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            bottom: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                // color: Colors.blue,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
