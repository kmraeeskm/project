import 'package:cet_hostel/screens/hostall_staff/complaints/complints.dart';
import 'package:cet_hostel/screens/hostall_staff/hostallallocation/hostallAloocation.dart';

import 'package:cet_hostel/screens/hostall_staff/room/room_home.dart';

import 'package:cet_hostel/screens/hostall_staff/studentManagment.dart';
import 'package:cet_hostel/screens/hostall_staff/studentmanagement/studentMnagementHome.dart';
import 'package:flutter/material.dart';

import '../warden/rules.dart';
import 'staffdetails/staffDetails.dart';

class HomePageforstaff extends StatefulWidget {
  @override
  State<HomePageforstaff> createState() => _HomePageforstaffState();
}

class _HomePageforstaffState extends State<HomePageforstaff> {
  navigate_to_studentManagement() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => studentManagement()),
    );
  }

  navigate_to_g() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HostelRulesPage()),
    );
  }

  navigate_to_HosteAllocation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HosteAllocationHome()),
    );
  }

  navigate_to_room() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => roomhome()),
    );
  }

  navigate_to_StaffDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfilePage(
                email: "wdhuqdhuw",
                phoneNumber: "827318748248",
                // position: "hwhjdsddD",
                name: "RAEES",
                profileImageUrl:
                    "https://firebasestorage.googleapis.com/v0/b/cethostel-f837e.appspot.com/o/Profilepics%2FEnoyUVco5wYye2IfB2zQqKSgf382?alt=media&token=f35f439a-f005-450b-aa8e-bf25fba1727d",
              )),
    );
  }

  navigate_to_ComplaintPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComplaintPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(1.0),
      //     child: Container(
      //       color: Colors.grey[400],
      //     ),
      //   ),
      //   title: Center(
      //     child: Text(
      //       'Complaints',
      //       style: TextStyle(color: Colors.black),
      //     ),
      //   ),
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    context,
                    'Student Management',
                    Icons.people_outline,
                    Colors.blue,
                    'studentManagement',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _buildMenuItem(
                    context,
                    'Attendance Management',
                    Icons.event_available_outlined,
                    Colors.purple,
                    'navigate_txo_complaint',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    context,
                    'Hostel Allocation',
                    Icons.hotel_outlined,
                    Colors.teal,
                    'Hostel Allocation',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _buildMenuItem(
                    context,
                    'Mess Bill Generation',
                    Icons.receipt_long_outlined,
                    Colors.green,
                    'navigate_to_cxomplaint',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    context,
                    'Complaint Management',
                    Icons.warning_amber_outlined,
                    Colors.red,
                    'ComplaintPage',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _buildMenuItem(
                    context,
                    'Update Staff Details',
                    Icons.supervisor_account_outlined,
                    Colors.orange,
                    'StaffDetailsPage',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    context,
                    'Room Management',
                    Icons.house,
                    Colors.red,
                    'room',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String fun,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (fun == 'navigate_to_g') {
            navigate_to_g();
          } else if (fun == 'studentManagement') {
            navigate_to_studentManagement();
          }
          if (fun == 'ComplaintPage') {
            navigate_to_ComplaintPage();
          }
          if (fun == 'StaffDetailsPage') {
            navigate_to_StaffDetailsPage();
          }
          if (fun == 'Hostel Allocation') {
            navigate_to_HosteAllocation();
          }
          if (fun == 'room') {
            navigate_to_room();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
