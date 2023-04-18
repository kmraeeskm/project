import 'package:cet_hostel/screens/student_admin/mainhome.dart';
import 'package:cet_hostel/screens/student_admin/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'EditMenuItemScreen.dart';

String items = "";

class nonvegmenu extends StatefulWidget {
  @override
  State<nonvegmenu> createState() => _nonvegmenuState();
}

class _nonvegmenuState extends State<nonvegmenu> {
  final List<String> daysOfWeek = ['sunday'];

  final List<String> meals = ['morning', 'noon', 'night'];
  Widget myCustomWidget(meal, day) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('menu')
          .doc('nonveg')
          .collection("nonveg")
          .doc(day)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          String m = snapshot.data!.get(meal);
          items = m;

          return Text(m);
        } else {
          return Text('Loading...');
        }
      },
    );
  }

  Future<String> getStringDataFromFirestore(
      String fieldName, String documentId) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('menu')
        .doc('nonveg')
        .collection('nonveg')
        .doc(documentId)
        .get();
    final data = documentSnapshot.data();
    final stringData = data![fieldName] as String;
    return stringData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 11, 11, 11), // Change the color here
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage(bar: 1)))
                .then((result) {
              // Handle the result returned from PageB
            });
            // Add your navigation logic here
          },
        ), // Set the background color to white
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(1.0), // Set the height of the bottom border line
          child: Container(
            color: Colors.grey, // Set the color of the bottom border line
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 55),
          child: Text(
            ' Non Veg Menu',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  daysOfWeek[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              Column(
                children: meals.map((meal) {
                  String day = daysOfWeek[index];
                  print(day);
                  return ListTile(
                    leading: Icon(Icons.restaurant),
                    title: Text(meal),
                    subtitle: myCustomWidget(
                      meal,
                      day,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditMenuItemScreen(
                                  time: meal, day: day, type: 'nonveg')),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
              Divider(
                thickness: 1.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
