import 'package:StudGo/Screens/home.dart';

import 'package:StudGo/widgets/TaskItem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

final taskRef = Firestore.instance.collection('tasks');

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String titleController;
  var contentController = '';

  void submit() async {
    if (!key.currentState.validate()) {
      // Invalid!
      return;
    }
    key.currentState.save();
    final doc =
        await taskRef.document(currentUser.email).collection('task').add({
      'content': contentController,
      'title': titleController,
      'done': false,
      'taskID': '',
    });
    await taskRef
        .document(currentUser.email)
        .collection('task')
        .document(doc.documentID)
        .updateData({
      'taskID': doc.documentID,
    });
    Navigator.of(context).pop();
  }

  void bottomModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(125),
                ),
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Title Cannot be Blank';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              titleController = newValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Title',
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.green[600],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                gapPadding: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          validator: (value) {
                            if (value.length > 40) {
                              return 'Too Long keep it short and crisp!';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            submit();
                          },
                          onSaved: (newValue) {
                            if (newValue.isEmpty) {
                              return;
                            }
                            contentController = newValue;
                          },
                          decoration: InputDecoration(
                            labelText: 'Add Task',
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.green[600],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              gapPadding: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        onPressed: submit,
                        child: Text('Add'),
                        color: Colors.green[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'StudGO',
          style: TextStyle(
              color: Colors.green[600],
              fontSize: 30,
              fontFamily: 'MavenPro',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
          stream: taskRef
              .document(currentUser.email)
              .collection('task')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.documents.length == 0) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'images/no_content.svg',
                        height: MediaQuery.of(context).size.height * 0.7,
                      ),
                      Text(
                        'No Tasks',
                        style: TextStyle(
                          color: Colors.green[600],
                          fontSize: 24,
                          fontFamily: 'MavenPro',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Stack(children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: ListView.builder(
                      reverse: false,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          content: snapshot.data.documents[index]['content'],
                          title: snapshot.data.documents[index]['title'],
                          docId: snapshot.data.documents[index]['taskID'],
                          done: snapshot.data.documents[index]['done'],
                        );
                      },
                      itemCount: snapshot.data.documents.length),
                ),
              ]);
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: bottomModalSheet,
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
