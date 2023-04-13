import 'package:cet_hostel/screens/student_admin/menu/nonvegmenu.dart';
import 'package:cet_hostel/screens/student_admin/menu/vegmenu.dart';
import 'package:flutter/material.dart';

class MenuSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white, // Set the background color to white
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(1.0), // Set the height of the bottom border line
          child: Container(
            color: Colors.grey, // Set the color of the bottom border line
          ),
        ),
        title: Container(
          // padding: EdgeInsets.only(left: 120),
          child: Center(
            child: Text(
              'Weekly Menu',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => vegmenu()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.green.withOpacity(0.8),
                ),
                margin: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.eco,
                      size: 100.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Veg Menu',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nonvegmenu()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red.withOpacity(0.8),
                ),
                margin: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_dining,
                      size: 100.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Non-Veg Menu',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
