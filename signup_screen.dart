import 'dart:typed_data';

import 'package:cet_hostel/resources/auth_methods.dart';
import 'package:cet_hostel/screens/login_screen.dart';
import 'package:cet_hostel/screens/student/mainnnhome.dart';
import 'package:cet_hostel/utils/colors.dart';
import 'package:cet_hostel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
    _phonecontroller.dispose();
  }

  void selectimage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void SignUpUser() async {
    setState(() {
      _isloading = true;
    });
    if (_emailcontroller.text.isEmpty ||
        _passwordcontroller.text.isEmpty ||
        _image!.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      String res = await AuthMethods().SignUpUser(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        username: _usernamecontroller.text,
        phone: _phonecontroller.text,
        file: _image!,
      );
      setState(() {
        _isloading = false;
      });
      if (res != 'Success') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => mainhomedecition(
                    b: c,
                  )),
        );
      }
    }
  }

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
                  _image != null
                      ? CircleAvatar(
                          radius: 84,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 84,
                          backgroundImage: AssetImage("assets/images/pro1.jpg"),
                        ),
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
              Text(
                "College of Engineering Trivandrum",
                style: TextStyle(
                  fontSize: 36,
                  height: h * 0.000001,
                  fontFamily: 'Cookie-Regular',
                ),
              ),
              const SizedBox(
                height: 46,
              ),
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
                    onTap: SignUpUser,
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            "Sign up",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Already have an account? '),
                  ),
                  GestureDetector(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  )
                ],
              ),
              // child: const Text('Log in'),
              // width: double.infinity,
              // alignment: Alignment.center,
              // padding: const EdgeInsets.symmetric(vertical: 12),
              // decoration: const ShapeDecoration(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(
              //         4,
              //       ),
              //     ),
              //   ),
              //   color: gre
              // ),

              //transition to signup
            ],
          ),
        ),
      ),
    );
  }
}
