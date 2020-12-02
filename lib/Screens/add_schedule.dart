import 'package:StudGo/Screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final schedref = Firestore.instance
    .collection('schedules')
    .document(currentUser.email)
    .collection('schedule');

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  var docId;
  bool docCreated = false;
  int dayCount;
  void submit() async {
    if (!key1.currentState.validate()) {
      // Invalid!
      return;
    }
    key1.currentState.save();
    final doc = await schedref.add({
      'title': titleController,
      'scheduleID': '',
      'dayCount': dayCount,
    });
    await schedref.document(doc.documentID).updateData({
      'scheduleID': doc.documentID,
    });
    print(doc.documentID);
    docId = doc.documentID;
    setState(() {
      docCreated = true;
    });
  }

  void submit1(int index) async {
    if (!key2.currentState.validate()) {
      // Invalid!
      return;
    }
    key2.currentState.save();
    await schedref
        .document(docId)
        .collection('dayPlan')
        .document('day${index + 1}')
        .setData({
      'day': index + 1,
      'subjects': [
        {
          'priority': priority,
          'subject': subjectController,
          'topics': topicsController,
        },
      ],
    });
    setState(() {
      itemcount++;
      subjectController = '';
      topicsController = '';
      priority = null;
      priorityController = '';
      key2.currentState.reset();
    });
    if (itemcount == dayCount) Navigator.of(context).pop();
  }

  GlobalKey<FormState> key1 = GlobalKey<FormState>();
  GlobalKey<FormState> key2 = GlobalKey<FormState>();
  var titleController = ' ';
  String subjectController;
  String topicsController;
  String priorityController;
  TextEditingController subtextcont;
  TextEditingController toptextcont;
  TextEditingController protextcont;

  var priority;
  int itemcount = 0;

  String dayController;
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
      body: docCreated != true
          ? SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                  key: key1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.98,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        width: MediaQuery.of(context).size.width * 0.98,
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            submit();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter a Number';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue.isEmpty) {
                              return;
                            }
                            dayController = newValue;
                            dayCount = int.parse(dayController);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Set Number of Days',
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
                        height: 23,
                      ),
                      FlatButton(
                        onPressed: submit,
                        child: Text('Next'),
                        color: Colors.green[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                  key: key2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Day ${(itemcount + 1).toString()}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.98,
                          child: TextFormField(
                            controller: subtextcont,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Subject Cannot be Blank';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              subjectController = newValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Subject',
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        width: MediaQuery.of(context).size.width * 0.98,
                        child: TextFormField(
                          controller: toptextcont,
                          onFieldSubmitted: (value) {},
                          onSaved: (newValue) {
                            if (newValue.isEmpty) {
                              return;
                            }
                            topicsController = newValue;
                          },
                          maxLines: 10,
                          decoration: InputDecoration(
                            labelText: 'Add topics',
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        width: MediaQuery.of(context).size.width * 0.98,
                        child: TextFormField(
                          controller: protextcont,
                          onFieldSubmitted: (value) {
                            submit1(itemcount);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Set priority';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue.isEmpty) {
                              return;
                            }
                            priorityController = newValue;
                            priority =
                                priorityController.toLowerCase() == 'high';
                          },
                          decoration: InputDecoration(
                            labelText: 'Set priority to low or high',
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
                        height: 23,
                      ),
                      FlatButton(
                        onPressed: () => submit1(itemcount),
                        child: Text('Add Day Details'),
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
    );
  }
}
