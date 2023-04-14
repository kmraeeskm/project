import 'dart:typed_data';

import 'package:cet_hostel/resources/auth_methods.dart';
import 'package:cet_hostel/screens/login_screen.dart';
import 'package:cet_hostel/screens/student/complintshome.dart';
import 'package:cet_hostel/utils/colors.dart';
import 'package:cet_hostel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../../widgets/text_field_input.dart';

class complintr extends StatefulWidget {
  const complintr({super.key});

  @override
  State<complintr> createState() => _complintrState();
}

class _complintrState extends State<complintr> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _discription = TextEditingController();

  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _title.dispose();

    _discription.dispose();
  }

  void selectimage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void registercomplaint() async {
    setState(() {
      _isloading = true;
    });
    if (_title.text.isEmpty || _discription.text.isEmpty || _image!.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      String res = await AuthMethods().complint_registration(
          title: _title.text, discription: _discription.text, file: _image!);
      setState(() {
        _isloading = false;
      });
      if (res != 'Success') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ComplaintPageView()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 11, 11, 11), // Change the color here
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            // Add your navigation logic here
          },
        ),
        title: Text(
          'Register complaint',
          style: TextStyle(color: Colors.black),
        ),
        // Add other AppBar properties here
      ),
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
              Text(
                "Register complaints here",
                style: TextStyle(
                  fontSize: 26,
                  height: h * 0.000001,
                  fontFamily: 'Open Sans',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // image
              Stack(
                children: [
                  _image != null
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image(
                            width: 300,
                            height: 300,
                            image: MemoryImage(
                              _image!,
                            ),
                          ),
                        )
                      // ? CircleAvatar(
                      //     radius: 84,
                      //     backgroundImage: MemoryImage(_image!),
                      //   )
                      // : const CircleAvatar(
                      //     radius: 84,
                      //     backgroundImage: AssetImage("assets/images/pro1.jpg"),
                      //   ),
                      : GestureDetector(
                          onTap: selectimage,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                        ),
                  // Positioned(
                  //   bottom: 100,
                  //   left: 70,
                  //   child: IconButton(
                  //     onPressed: selectimage,
                  //     icon: const Icon(
                  //       Icons.add_a_photo,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              // ignore: prefer_const_constructors

              //textfield for username
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(2),
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       blurRadius: 10,
                //       spreadRadius: 7,
                //       offset: Offset(1, 1),
                //       color: Colors.white.withOpacity(0.2),
                //     ),
                //   ],
                // ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter title',
                    textInputType: TextInputType.text,
                    textEditingController: _title,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              //textfield for phoneno
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.horizontal(),
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       blurRadius: 10,
                //       spreadRadius: 7,
                //       offset: Offset(1, 1),
                //       color: Colors.white.withOpacity(0.2),
                //     ),
                //   ],
                // ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter discription',
                    textInputType: TextInputType.text,
                    textEditingController: _discription,
                  )
                ]),
              ),

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
                    onTap: registercomplaint,
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            "Register",
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
