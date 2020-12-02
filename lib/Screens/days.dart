import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/widgets/dayItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final dayref = Firestore.instance
    .collection('schedules')
    .document(currentUser.email)
    .collection('schedule')
    .document()
    .collection('dayPlan')
    .snapshots();

class Days extends StatefulWidget {
  final scheduleID;

  Days({this.scheduleID});
  @override
  _DaysState createState() => _DaysState();
}

class _DaysState extends State<Days> {
  @override
  Widget build(BuildContext context) {
    final dayref = Firestore.instance
        .collection('schedules')
        .document(currentUser.email)
        .collection('schedule')
        .document(widget.scheduleID)
        .collection('dayPlan')
        .getDocuments();

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
      body: FutureBuilder(
        future: dayref,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              cacheExtent: 100000000,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                List<dynamic> subjects =
                    (snapshot.data.documents[index]['subjects']);
                int day = snapshot.data.documents[index]['day'];
                return DayItem(
                  day: day,
                  subjects: subjects,
                  scheduleId: widget.scheduleID,
                );
              });
        },
      ),
    );
  }
}
