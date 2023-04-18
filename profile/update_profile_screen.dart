import 'package:cet_hostel/screens/profile/profile_screen.dart';
import 'package:cet_hostel/utils/colors.dart';
import 'package:cet_hostel/utils/utils.dart';
import 'package:cet_hostel/widgets/text_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

Uint8List? photo;
bool _isloading = false;

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserdetails();
  }

  void selectimage() async {
    Uint8List? im = await pickimage(ImageSource.gallery);
    setState(() {
      photo = im;
    });
  }

  Future<String> getUserdetails() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        username = documentSnapshot.get('username');
        photo = documentSnapshot.get('photourl');
        String pp = photo.toString();

        //email = documentSnapshot.get('email');
        //print("hi");
        // print(photo);
      } else {
        print("not exist");
      }
    });
    return username;
  }

  void update() async {
    setState(() {
      _isloading = true;
    });
    if (_emailcontroller.text.isEmpty ||
        _passwordcontroller.text.isEmpty ||
        pp.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? username = auth.currentUser;
      if (username != null) {
        String uid = username.uid;
        // Access the user's UID here
      }
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child("users").child(username!.uid);
      userRef.update({
        "username": _usernamecontroller.text,
        "email": _emailcontroller.text,
        "phone": _phonecontroller.text,
        "photourl": pp,
      }).then((value) {
        // Profile data updated successfully
      }).catchError((error) {
        // Error occurred while updating profile data
      });
    }
  }

  final _collectionRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 84,
              ),
              // image
              Stack(
                children: [
                  StreamBuilder(
                    stream: _collectionRef
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green)));
                      } else {
                        return Container(
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                NetworkImage(snapshot.data.get('photourl')),
                          ),
                        );
                      }
                    },
                  ),
                  // CircleAvatar(
                  //   radius: 84,
                  //   backgroundImage: NetworkImage(pp),
                  // ),
                  Positioned(
                    bottom: -10,
                    left: 90,
                    child: IconButton(
                      onPressed: selectimage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              // ignore: prefer_const_constructors

              //textfield for username
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter username',
                    textInputType: TextInputType.text,
                    textEditingController: _usernamecontroller,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              //textfield for phoneno
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter phoneno',
                    textInputType: TextInputType.phone,
                    textEditingController: _phonecontroller,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),

              //textfield for email

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailcontroller,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              //textfield for password
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordcontroller,
                    isPass: true,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(),
              //     ),
              //     Text(
              //       "Forgot your Password?  ",
              //       style: TextStyle(fontSize: 15, color: Colors.black),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 26,
              ),
              //button

              Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/grey2.jpg",
                      ),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: InkWell(
                    onTap: update,
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
