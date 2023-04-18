import 'package:cet_hostel/screens/warden/complaints/complints.dart';
import 'package:cet_hostel/screens/warden/notification/notifacation.dart';
import 'package:cet_hostel/screens/warden/rules.dart';
import 'package:flutter/material.dart';

class HomePageforwarden extends StatefulWidget {
  const HomePageforwarden({Key? key}) : super(key: key);

  @override
  State<HomePageforwarden> createState() => _HomePageforwardenState();
}

class _HomePageforwardenState extends State<HomePageforwarden> {
  navigate_to_complaint() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComplaintPage()),
    );
  }

  navigate_to_notification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => notificationhome()),
    );
  }

  navigate_to_rules() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HostelRulesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[400],
          ),
        ),
        title: Center(
          child: Text(
            'HOME',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 66,
            crossAxisSpacing: 33,
            children: [
              HomeItem(
                title: 'Student Management',
                icon: Icons.person,
                color: Colors.blue,
                onTap: () {
                  // Add navigation logic here
                },
              ),
              HomeItem(
                title: 'Staff Management',
                icon: Icons.people_alt,
                color: Colors.orange,
                onTap: () {
                  // Add navigation logic here
                },
              ),
              HomeItem(
                title: 'Security Management',
                icon: Icons.security_outlined,
                color: Colors.redAccent,
                onTap: () {
                  // Add navigation logic here
                },
              ),
              HomeItem(
                title: 'Complaint Management',
                icon: Icons.warning_amber_outlined,
                color: Colors.amber,
                onTap: () {
                  navigate_to_complaint();
                },
              ),
              HomeItem(
                title: 'Notification Management',
                icon: Icons.notifications_active_outlined,
                color: Colors.green,
                onTap: () {
                  navigate_to_notification();
                },
              ),
              HomeItem(
                title: 'Enforcing Hostel Rules',
                icon: Icons.rule_folder_outlined,
                color: Colors.deepPurple,
                onTap: () {
                  navigate_to_rules();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: color),
            SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
