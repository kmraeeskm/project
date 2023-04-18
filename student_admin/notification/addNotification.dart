import 'package:flutter/material.dart';

import '../../../resources/auth_methods.dart';
import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../mainhome.dart';
import 'package:intl/intl.dart';

class addnotification extends StatefulWidget {
  @override
  _addnotificationState createState() => _addnotificationState();
}

class _addnotificationState extends State<addnotification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  bool _isloading = false;
  String _selectedtype = 'Normal';
  void pushnotification() async {
    String formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
    String selectedTime = _selectedTime.format(context);
    setState(() {
      _isloading = true;
    });
    if (_messageController.text.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      String res = await AuthMethods().push_notification(
        text: _messageController.text,
        duedate: formattedDate,
        duetime: selectedTime,
        selectedtype: _selectedtype,
      );
      setState(() {
        _isloading = false;
      });
      if (res != 'Success') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage(bar: 3)),
        );
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  TimeOfDay _selectedTime = TimeOfDay(hour: 23, minute: 59);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    return picked;
  }

  // late DateTime _selectedDate;
  late DateTime _selectedDate = DateTime.now();
  bool seldate = false;
  bool sel = false;
  @override
  Widget build(BuildContext context) {
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
        title: Container(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            "Add notifications",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // Add other AppBar properties here
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Notification Text',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a notification text';
                  }
                  return null;
                },
                maxLines: null,
              ),
              SizedBox(
                height: 20,
              ),
              !seldate
                  ? Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 3, 116, 27),
                        ),
                        onPressed: () async {
                          DateTime? picked = await _selectDate(context);
                          if (picked != null) {
                            setState(() {
                              _selectedDate = picked;
                            });
                            seldate = true;
                          }
                        },
                        child: Text('Select Date'),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Selected date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                        style: TextStyle(fontSize: 24, color: Colors.green),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              !sel
                  ? Center(
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 3, 116, 27),
                      ),
                      onPressed: () {
                        _selectTime(context);
                        sel = true;
                      },
                      child: Text('Select Time'),
                    ))
                  : Center(
                      child: Text(
                        'Selected time: ${_selectedTime.format(context)}',
                        style: TextStyle(fontSize: 24, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    " Type of notification  : ",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  DropdownButton<String>(
                    value: _selectedtype,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedtype = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          'Emergency',
                          style: TextStyle(color: Colors.red),
                        ),
                        value: 'Emergency',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Normal',
                          style: TextStyle(color: Colors.green),
                        ),
                        value: 'Normal',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        pushnotification();
                      }
                    },
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : Center(child: Text('Submit Notification')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class MyTimePicker extends StatefulWidget {
//   @override
//   _MyTimePickerState createState() => _MyTimePickerState();
// }

// class _MyTimePickerState extends State<MyTimePicker> {
  // TimeOfDay _selectedTime = TimeOfDay(hour: 8, minute: 0);

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime,
  //   );
  //   if (picked != null && picked != _selectedTime) {
  //     setState(() {
  //       _selectedTime = picked;
  //     });
  //   }
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Selected time: ${_selectedTime.format(context)}',
//             style: TextStyle(fontSize: 24),
//           ),
//           ElevatedButton(
//             onPressed: () => _selectTime(context),
//             child: Text('Select Time'),
//           ),
//         ],
//       ),
//     );
//   }
// }
