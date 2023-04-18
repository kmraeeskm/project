import 'package:cet_hostel/screens/hostall_staff/room/room_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../resources/auth_methods.dart';
import '../../../utils/utils.dart';

class CreateRoomPage extends StatefulWidget {
  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  String roomid = "";
  final _roomNameController = TextEditingController();
  final _corryController = TextEditingController();
  final _floorNameController = TextEditingController();
  bool _isloading = false;

  void saveroom() async {
    setState(() {
      _isloading = true;
    });
    if (_roomNameController.text.isEmpty ||
        _corryController.text.isEmpty ||
        _floorNameController.text.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      String res = await AuthMethods().saveroom(
          corry: _corryController.text,
          floor: _floorNameController.text,
          id: _roomNameController.text);
      setState(() {
        _isloading = false;
      });
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection('Rooms')
          .doc(_roomNameController.text)
          .collection('attendence');
      if (res != 'Success') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => roomhome()),
        );
      }
    }
  }

  @override
  void initState() {
    getLastDocId();
    super.initState();
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    _corryController.dispose();
    super.dispose();
  }

  Future<String?> getLastDocId() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Rooms')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      final lastDocId = querySnapshot.docs.first.id;
      print(lastDocId);
      roomid = lastDocId;
      int num = int.parse(lastDocId);
      num = num + 1;
      _roomNameController.text = num.toString().padLeft(2, '0');
      ;

      return lastDocId;
    } catch (e) {
      print('Error getting last document ID: $e');
      return null;
    }
  }

  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Room'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add a new room',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                controller: _roomNameController,
                decoration: InputDecoration(
                  labelText: 'Room Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _corryController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'corry Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                controller: _floorNameController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  labelText: 'floor Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text(
                  'Create Room',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                // color: Colors.blue,
                onPressed: () {
                  _focusNode.unfocus();
                  saveroom();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
