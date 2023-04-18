// import 'package:flutter/material.dart';

// class MyNavBar extends StatefulWidget {
//   @override
//   _MyNavBarState createState() => _MyNavBarState();
// }

// class _MyNavBarState extends State<MyNavBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       backgroundColor: Colors.white,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Search',

//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: 'Favorites',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }

import 'package:cet_hostel/screens/student_admin/attedence/home.dart';
import 'package:flutter/material.dart';

import 'complaints/complints.dart';
import 'menu/nonvegmenu.dart';

import 'menu/menu.dart';
import 'notification/addNotification.dart';
import 'notification/notifacation.dart';

class HomePage extends StatefulWidget {
  int bar;
  HomePage({required this.bar});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      widget.bar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _selectedIndex = widget.bar;
    print(widget.bar);
    return Scaffold(
      body: Center(
        child: _getPage(widget.bar),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: const TextStyle(fontSize: 5),
        // backgroundColor: Color.fromARGB(255, 34, 214, 214),
        fixedColor: Colors.blue,
        // unselectedItemColor: const Color.fromARGB(255, 146, 1, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check,
              size: 25.0,
              color: Colors.grey,
            ),
            label: 'ATTENDENCE',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_dining,
              size: 25.0,
              color: Colors.grey,
            ),
            label: 'MENU',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.warning,
              size: 25.0,
              color: Colors.grey,
            ),
            label: 'COMPLAINT',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 25.0,
              color: Colors.grey,
            ),
            label: 'NOTIFICATION',
          ),
        ],
        currentIndex: widget.bar,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return ViewAllRooms();
      case 1:
        return MenuSelectionPage();
      case 2:
        return ComplaintPage();
      case 3:
        return notificationhome();
      default:
        return ViewAllRooms();
    }
  }
}
