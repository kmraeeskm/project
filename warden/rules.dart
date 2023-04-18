import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../resources/auth_methods.dart';
import '../../utils/utils.dart';
import 'home.dart';

class HostelRulesPage extends StatefulWidget {
  const HostelRulesPage({Key? key}) : super(key: key);

  @override
  _HostelRulesPageState createState() => _HostelRulesPageState();
}

class _HostelRulesPageState extends State<HostelRulesPage> {
  final TextEditingController _ruleController = TextEditingController();
  final TextEditingController _penaltyController = TextEditingController();
  bool _isloading = false;

  void saverules() async {
    setState(() {
      _isloading = true;
    });
    if (_ruleController.text.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      String res = await AuthMethods().saverules(text: _ruleController.text);
      setState(() {
        _isloading = false;
      });
      if (res != 'Success') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HostelRulesPage()),
        );
      }
    }
  }

  void savepenalty() async {
    setState(() {
      _isloading = true;
    });
    if (_penaltyController.text.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      String res =
          await AuthMethods().savepenalty(text: _penaltyController.text);
      setState(() {
        _isloading = false;
      });
      if (res != 'Success') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HostelRulesPage()),
        );
      }
    }
  }

  void deleterules(data) {
    final docRef =
        FirebaseFirestore.instance.collection('rules').doc(data['time']);

    docRef
        .delete()
        .then((value) => print("Document deleted"))
        .catchError((error) => print("Failed to delete document: $error"));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => HostelRulesPage()));
  }

  void deletepenalty(data) {
    final docRef =
        FirebaseFirestore.instance.collection('penalty').doc(data['time']);

    docRef
        .delete()
        .then((value) => print("Document deleted"))
        .catchError((error) => print("Failed to delete document: $error"));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => HostelRulesPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 11, 11, 11), // Change the color here
        ),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomePageforwarden()),
            );
            // Add your navigation logic here
          },
        ),
        title: Container(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            "Enforcing Hostel Rules",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // Add other AppBar properties here
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rules and Regulations',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('rules')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(data['text'],
                              style: Theme.of(context).textTheme.subtitle1),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleterules(data);
                              }),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 0),
              TextField(
                controller: _ruleController,
                decoration: InputDecoration(
                  hintText: 'Add a new rule',
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        saverules();

                        _ruleController.clear();
                      });
                    },
                    child: Text('Add'),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Penalties for Violation',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('penalty')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(data['text'],
                              style: Theme.of(context).textTheme.subtitle1),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deletepenalty(data);
                              }),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _penaltyController,
                decoration: InputDecoration(
                  hintText: 'Add a new penalty',
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        savepenalty();

                        _penaltyController.clear();
                      });
                    },
                    child: Text('Add'),
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


// ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: rules.length,
//                   itemBuilder: (context, index) => ListTile(
//                     title: Text(rules[index],
//                         style: Theme.of(context).textTheme.subtitle1),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () => setState(() => rules.removeAt(index)),
//                     ),
//                   ),
//                 ),