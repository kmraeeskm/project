import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../responsive/mobile_screen_layout.dart';
import '../profile/update_profile_screen.dart';
import 'applayhostall/applayHostall.dart';

class mainhomedecition extends StatefulWidget {
  final bool b;

  const mainhomedecition({Key? key, required this.b}) : super(key: key);

  @override
  _mainhomedecitionState createState() => _mainhomedecitionState();
}

class _mainhomedecitionState extends State<mainhomedecition> {
  @override
  void initState() {
    super.initState();
    //   getUserData();
  }

  // Replace with the actual user ID

  // getUserData() async {
  //   final userDoc = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid);
  //   print(FirebaseAuth.instance.currentUser!.uid);
  //   try {
  //     DocumentSnapshot userSnapshot = await userDoc.get();
  //     if (userSnapshot.exists) {
  //       Map<String, dynamic> userData =
  //           userSnapshot.data() as Map<String, dynamic>;
  //       String name = userData['roomid'] as String;

  //       print('User name is $name');
  //       if (name == "") {
  //         c = true;
  //         print(c);
  //       } else {
  //         c = false;
  //         print(c);
  //       }
  //     } else {
  //       print('User does not exist');
  //     }
  //   } catch (e) {
  //     print('Error retrieving user data: $e');
  //   }
  // }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Future.delayed(Duration.zero, () {
      if (widget.b == true) {
        print(widget.b);
        print('inside first');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyDropdown()),
        );
      } else {
        print(widget.b);
        print('inside second');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Here you can build your widget tree
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Text("Loading..."),
      ),
    );
  }
}
