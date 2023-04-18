import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class allotted_students extends StatefulWidget {
  @override
  _allotted_studentsState createState() => _allotted_studentsState();
}

class _allotted_studentsState extends State<allotted_students> {
  void initState() {
    super.initState();
    updateValueInFirebase();
  }

  Future<void> updateValueInFirebase() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('status', isEqualTo: 'proccessing')
        .limit(2)
        .get();
    for (final doc in querySnapshot.docs) {
      await doc.reference.update({'status': 'watingforroom'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allotted student'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'watingforroom')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              final userData = data.docs[index].data() as Map<String, dynamic>;
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(userData['photourl']),
                  ),
                  title: Text(
                    userData['username'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    userData['email'],
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Implement onTap functionality
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your logic here
        },
        label:
            Text('give response to students', style: TextStyle(fontSize: 16.0)),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
      ),
    );
  }
}
