import 'package:flutter/material.dart';

class StudentManagementScreen extends StatefulWidget {
  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hostel Allocation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),
            _buildHostelAllocationList(),
            SizedBox(height: 32.0),
            Text(
              'Student List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),
            _buildStudentList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHostelAllocationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'List of students who have been allocated a hostel:',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 200.0,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text('Student ${index + 1}'),
                subtitle: Text('Hostel A, Room ${index + 1}'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStudentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'List of all students:',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 200.0,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text('Student ${index + 1}'),
                subtitle: Text('Class 10th, Section A'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Navigate to hostel allocation screen for this student
                  },
                  child: Text('Allocate Hostel'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
